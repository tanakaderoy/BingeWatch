//
//  SeasonInfoViewController.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/3/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit
import Siesta
import Kingfisher

enum ImageSize: String {
    case w92 = "w92"
    case w154 = "w154"
    case w185 = "w185"
    case w342 = "w342"
    case w500 = "w500"
    case w780 = "w780"
    case original = "original"
}


class SeasonInfoViewController: UIViewController {
    var id: String?
    var seasonNumber: String?
    var showName: String?
    @IBOutlet weak var tableView: UITableView!
    var seasonInfo: SeasonModel? {
        didSet{
            if let season = seasonInfo{
                self.episodes = season.episodes
                navigationItem.title = "Season \(season.seasonNumber ?? 0)"
                if let episode = episode{

                    guard let epIdx = Int(episode) else {return}

                    let index = epIdx-1
                     print("Episode: ", episodes[index].name)
                    let indexPath = IndexPath(row: index, section: 0)
                    tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                }
                
                //self.seasonNumber = String(season.seasonNumber!)
            }
        }
    }
    var episode: String?
    private var episodes: [Episode] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    private var statusOverlay = ResourceStatusOverlay()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = id, let seasonNumber = seasonNumber{
            TMDBAPI.sharedInstance.getSeasonInfo(showId: id, seasonNumber: seasonNumber)
                .addObserver(self)
                .addObserver(statusOverlay, owner: self)
                .loadIfNeeded()?.onSuccess({ (entity) in
                    print(entity.content)
                }).onFailure({ (error) in
                    print(error)
                })
        }
        statusOverlay.embed(in: self)
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusOverlay.positionToCoverParent()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension SeasonInfoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let showName = showName{
            JustWatchAPI.sharedInstance.searchForShow(showName: showName)?.onSuccess({ (entity) in
                let showJW = entity.content as? ShowJWModel
                
                if let showJW = showJW{
                    
                    if let offers = showJW.items.first?.offers{
                        print("offers: ",offers)
                        if #available(iOS 13.0, *) {
                            if let vc = self.storyboard?.instantiateViewController(identifier: "provider") as? ProviderViewController{
                                vc.offers = offers
                                self.present(vc, animated: true, completion: nil)
                            }
                        } else {
                            // Fallback on earlier versions
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "provider") as! ProviderViewController
                            vc.offers = offers
                            var episode = self.episodes[indexPath.row]
                            vc.title = episode.name
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                        
                        
                        
                    }
                }
            }).onFailure({ (error) in
                print(error)
            })
            // your code here, get the row for the indexPath or do whatever you want
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        let episode = episodes[indexPath.row]
        cell.episodeTitleLabel.text = episode.name ?? "N/A"
        cell.episodeOverViewLabel.text = episode.overview ?? "N/A"
        cell.episodeAirdateLabel.text = episode.airDate ?? "N/A"
        if let stillPath = episode.stillPath{
            cell.episodeImageView.kf.setImage(with: URL(string: imageBaseUrl+stillPath))
        }
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

extension SeasonInfoViewController: ResourceObserver{
    func resourceChanged(_ resource: Siesta.Resource, event: ResourceEvent) {
        seasonInfo = resource.typedContent()
    }
    
    
}
