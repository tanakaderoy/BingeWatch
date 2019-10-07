//
//  TrendingViewController.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/1/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit
import Siesta
import Kingfisher

class TrendingViewController: UIViewController, UIGestureRecognizerDelegate {
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    @IBOutlet weak var tableView: UITableView!
    private var shows: [TvShowResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var offers = [Offer]()

    var tvShowListResource: Siesta.Resource? {
        didSet{
            oldValue?.removeObservers(ownedBy: self)
            tvShowListResource?
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    private var statusOverlay = ResourceStatusOverlay()
    override func viewDidLoad() {
        super.viewDidLoad()
        statusOverlay.embed(in: self)
        tvShowListResource = TMDBAPI.sharedInstance.getTrendingShows()
        // Do any additional setup after loading the view.

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
setupLongPressGesture()
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
                            if let top = offers.first{
            
                                self.offers = offers
                                self.performSegue(withIdentifier: "homeToProvider", sender: nil)

                            }
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
        if segue.identifier == "homeToProvider"{
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

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendingShowCell", for: indexPath) as! TvShowTableViewCell
        let show = shows[indexPath.row]
        cell.tvShowNameLabel.text = show.name
        cell.tvShowNameLabel.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        let url = URL(string: imageBaseUrl+show.posterPath)
        cell.posterImageView.kf.setImage(with: url)
        cell.ratingLabel.text = String(show.voteAverage)
        cell.ratingLabel.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        cell.tvShowFirstAirdateLabel.backgroundColor =  UIColor(white: 1, alpha: 0.5)
        cell.summaryLabel.text = show.overview
        cell.summaryLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        let backgroundImage = UIImageView(frame: cell.bounds)
        backgroundImage.kf.setImage(with: URL(string:imageBaseUrl+show.backdropPath))
        backgroundImage.contentMode = .scaleAspectFill
        cell.backgroundView = backgroundImage
        cell.selectionStyle = .none
        return cell
    }


}

extension TrendingViewController: ResourceObserver {
    func resourceChanged(_ resource: Siesta.Resource, event: ResourceEvent) {
        shows = resource.typedContent() ?? []
    }
}
