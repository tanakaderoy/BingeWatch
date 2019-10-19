//
//  SearchShowViewController.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/2/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit
import Siesta

class SearchShowViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var offers = [Offer]()


    private var shows: [ShowSearchResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var tvShowListResource: Siesta.Resource? {
        didSet{
            oldValue?.removeObservers(ownedBy: self)
            tvShowListResource?
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .load().onSuccess({ (entity) in
                    print(entity.content)
                }).onFailure({ (error) in
                    print(error)
                })
        }
    }
    private var statusOverlay = ResourceStatusOverlay()
    fileprivate func setUpTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        statusOverlay.embed(in: self)
        tvShowListResource = TMDBAPI.sharedInstance.getTrendingShows()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        tableView.keyboardDismissMode = .onDrag

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        setupLongPressGesture()
        setUpTapGesture()

    }
    @objc func handleTap(){
        self.searchBar.resignFirstResponder()
    }
    func setupLongPressGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }

    @objc func longPressed(sender: UILongPressGestureRecognizer) {

        if sender.state == UIGestureRecognizer.State.began {

            let touchPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                JustWatchAPI.sharedInstance.searchForShow(showName: shows[indexPath.row].name)?.onSuccess({ (entity) in
                    let showJW = entity.content as? ShowJWModel

                    if let showJW = showJW{

                        if let offers = showJW.items.first?.offers{
                            print("offers: ",offers)

                                self.offers = offers
                                self.performSegue(withIdentifier: "searchToProvider", sender: nil)


                        }
                    }
                }).onFailure({ (error) in
                    print(error)
                })
                // your code here, get the row for the indexPath or do whatever you want
            }
        }
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.tabBarController!.selectedIndex += 1
        }
        if sender.direction == .right {
            self.tabBarController!.selectedIndex -= 1
        }
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "searchToProvider"{
            let vc = segue.destination as! ProviderViewController

            vc.offers = offers

        }else{
            let vc = segue.destination as! ShowViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let show = shows[indexPath.row]
            vc.id = String(show.id)
        }
    }


}
extension SearchShowViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchShowCell", for: indexPath) as! TvShowSearchTableViewCell
        let show = shows[indexPath.row]

        cell.tvShowSearchNameLabel.text = show.name
        cell.tvShowSearchNameLabel.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        if let posterPath = show.posterPath, let airdate = show.firstAirDate, let backdropPath = show.backdropPath {
            let url = URL(string: imageBaseUrl+posterPath)
            cell.searchPosterImageView.kf.setImage(with: url)
            cell.tvShowSearchFirstAirdateLabel.text = getYearFromDateString(dateString: airdate)
            let backgroundImage = UIImageView(frame: cell.bounds)
            
            backgroundImage.kf.setImage(with: URL(string:imageBaseURLChooseSize+ImageSize.original.rawValue+show.backdropPath!))
            backgroundImage.contentMode = .scaleAspectFill
            cell.backgroundView = backgroundImage
        }else{
            cell.searchPosterImageView.image = imageFromText(text: show.name)
             let backgroundImage = UIImageView(frame: cell.bounds)
            backgroundImage.image = imageFromText(text: show.name)
             cell.backgroundView = backgroundImage
        }

        cell.ratingSearchLabel.text = String(show.voteAverage)
        cell.ratingSearchLabel.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        cell.tvShowSearchFirstAirdateLabel.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        cell.searchSummaryTextView.text = show.overview
        cell.searchSummaryTextView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.selectionStyle = .none

        return cell
    }
    func imageFromText(text:String)->UIImage?{
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.yellow,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)
        ]
        let textSize = text.size(withAttributes: attributes)

        UIGraphicsBeginImageContextWithOptions(textSize, true, 0)
        text.draw(at: CGPoint.zero, withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }


}

extension SearchShowViewController: ResourceObserver {
    func resourceChanged(_ resource: Siesta.Resource, event: ResourceEvent) {
        shows = resource.typedContent() ?? []
    }


}

extension SearchShowViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else{ return}
        tvShowListResource = TMDBAPI.sharedInstance.searchWithQuery(searchQuery: query)
        view.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

}
