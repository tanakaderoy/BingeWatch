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
import FirebaseUI


class TrendingViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var signInOutButton: UIBarButtonItem!

    @IBOutlet weak var tableView: UITableView!
   //For Pagination
   var isDataLoading:Bool=false
   var pageNo:Int=1
   var limit:Int=20
   var offset:Int=0 //pageNo*limit
   var didEndReached:Bool=false

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
                .loadIfNeeded()?.onFailure({ (error) in
                    print(error.cause)
                })
        }
    }
    private var statusOverlay = ResourceStatusOverlay()
    fileprivate func setUpSwipeGestures() {
        // Do any additional setup after loading the view.

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil{
            signInOutButton.title = "Sign In"
        }
        statusOverlay.embed(in: self).positionToCover(view)
        tvShowListResource = TMDBAPI.sharedInstance.getTrendingShows(page: String(pageNo))
        tabBarController?.delegate = self

        setUpSwipeGestures()
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
                                if #available(iOS 13.0, *) {
                                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "provider") as? ProviderViewController{
                                        vc.offers = offers
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                } else {
                                    // Fallback on earlier versions
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "provider") as! ProviderViewController
                                    vc.offers = offers
                                    let show = self.shows[indexPath.row]
                                    vc.title = show.name
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                                
                            }
                        }
                    }
                }).onFailure({ (error) in
                    print(error)
                })
            }
            
        }
    }
    
    
    @IBAction func signInOrOutButtonTouched(_ sender: Any) {
        let loginVC = LoginViewController()
                   loginVC.modalPresentationStyle = .fullScreen
        if(Auth.auth().currentUser != nil){
         try! Auth.auth().signOut()

            self.present(loginVC, animated: true, completion: nil)
        }else{
            self.present(loginVC, animated: true, completion: nil)

        }
    }
    
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        guard let limit = self.tabBarController?.viewControllers?.count else {return}
        
        if sender.direction == .left {
            let index = self.tabBarController!.selectedIndex + 1
            if !(index > limit) {
                _ = tabBarController(self.tabBarController!, shouldSelect: self.tabBarController!.viewControllers![index])
                self.tabBarController!.selectedIndex = index
                print(index)
            }
            
        }
        if sender.direction == .right {
            let index = self.tabBarController!.selectedIndex - 1
            if !(index < 0){
                _ = tabBarController(self.tabBarController!, shouldSelect: self.tabBarController!.viewControllers![index])
                
                self.tabBarController!.selectedIndex = index
                print(index)
            }
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
        cell.tvShowNameLabel.backgroundColor =  UIColor(white: 0, alpha: 0.5)
        let url = URL(string: imageBaseUrl+show.posterPath)
        cell.posterImageView.kf.setImage(with: url)
        cell.ratingLabel.text = String(show.voteAverage)
        cell.ratingLabel.backgroundColor =  UIColor(white: 0, alpha: 0.5)
        cell.tvShowFirstAirdateLabel.backgroundColor =  UIColor(white: 0, alpha: 0.5)
        cell.tvShowFirstAirdateLabel.text = getYearFromDateString(dateString: show.firstAirDate)
        cell.summaryLabel.text = show.overview
        cell.summaryLabel.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let backgroundImage = UIImageView(frame: cell.bounds)
        backgroundImage.kf.setImage(with: URL(string:imageBaseURLChooseSize+ImageSize.original.rawValue+show.backdropPath))
        backgroundImage.contentMode = .scaleAspectFill
        cell.backgroundView = backgroundImage
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension TrendingViewController: ResourceObserver {
    func resourceChanged(_ resource: Siesta.Resource, event: ResourceEvent) {
        let newShows:[TvShowResult] = resource.typedContent() ?? []

        shows.append(contentsOf:newShows)
    }
}

extension TrendingViewController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let fromView: UIView = tabBarController.selectedViewController!.view
        let toView  : UIView = viewController.view
        if fromView == toView {
            return false
        }
        
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve) { (finished:Bool) in
            
        }
        return true
    }
}

extension TrendingViewController: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }



    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

            print("scrollViewDidEndDragging")
            if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
            {
                if !isDataLoading{
                    isDataLoading = true
                    self.pageNo=self.pageNo+1
                    self.limit=self.limit+10
                    self.offset=self.limit * self.pageNo
                    tvShowListResource = TMDBAPI.sharedInstance.getTrendingShows(page: String(self.pageNo))

                }
            }


    }
}
