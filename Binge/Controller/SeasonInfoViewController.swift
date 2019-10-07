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



class SeasonInfoViewController: UIViewController {
    var id: String?
    var seasonNumber: String?
    let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    @IBOutlet weak var tableView: UITableView!
    var seasonInfo: SeasonModel? {
        didSet{
            if let season = seasonInfo{
                self.episodes = season.episodes
                navigationItem.title = "Season \(season.seasonNumber ?? 0)"

                //self.seasonNumber = String(season.seasonNumber!)
            }
        }
    }
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeTableViewCell
        let episode = episodes[indexPath.row]
        cell.episodeTitleLabel.text = episode.name ?? "adsa"
        cell.episodeOverViewLabel.text = episode.overview ?? "asds"
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
