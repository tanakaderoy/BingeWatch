//
//  ShowViewController.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/3/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit
import Siesta
import Kingfisher

class ShowViewController: UIViewController {
    @IBOutlet weak var tvShowInfoNameLabel: UILabel!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var networkLogoImageView: UIImageView!
    @IBOutlet weak var bingeButton: UIButton!
    
    var id: String?
    var randomEpisode: String?
    var sentSeasonNo: String?
    var showName: String?
    var tvShow: TvShowModel? {
        didSet{
            if let show = tvShow{
                self.seasons = show.seasons!
                showName = show.name
                tvShowInfoNameLabel.text = show.name
                navigationItem.title = show.name
                self.collectionView.reloadData()
                if let backdropPath = show.backdropPath{
                    backdropImageView.kf.setImage(with: URL(string: imageBaseURLChooseSize+ImageSize.original.rawValue+backdropPath))
                }
                if let networks = show.networks{
                    guard let network = networks.first else{return}
                    if let logoPath = network.logoPath{
                        networkLogoImageView.backgroundColor = UIColor(white: 1, alpha: 0.1)
                        networkLogoImageView.kf.setImage(with: URL(string: imageBaseUrl+logoPath))
                    }
                }
            }
        }
    }
    var seasons: [Season] = [Season]()
    private var statusOverlay = ResourceStatusOverlay()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.topAnchor.constraint(equalTo: tvShowInfoNameLabel.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bingeButton.topAnchor, constant: 0).isActive = true










        guard let id = id else { return}
        TMDBAPI.sharedInstance.getShow(showId: id)
            .addObserver(self)
            .addObserver(statusOverlay, owner: self)
            .loadIfNeeded()?.onSuccess({ (entity) in
                print(entity.content)
            }).onFailure({ (error) in
                print(error)
            })
        

        statusOverlay.embed(in: self)

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusOverlay.positionToCoverParent()
    }

    @IBAction func bingeButtonPressed(_ sender: UIButton) {
        if let season = seasons.randomElement(), let seasonNumber = season.seasonNumber, let episodeCount = season.episodeCount{
            randomEpisode = String(arc4random_uniform(UInt32(episodeCount)))
            sentSeasonNo = String(seasonNumber)


             print("peform binge")
            if #available(iOS 13.0, *) {
                let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "seasonInfo") as! SeasonInfoViewController
                vc.id = String(self.id!)
                vc.showName = showName
                            vc.seasonNumber = sentSeasonNo
                            vc.episode = randomEpisode
                navigationController?.pushViewController(vc, animated: true)
            } else {
                // Fallback on earlier versions
            }


        }
        
    }

    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SeasonCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()


    
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "showSeasonInfo"{
        let vc = segue.destination as! SeasonInfoViewController
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return}
            let season = seasons[indexPath.row]
            vc.seasonNumber = String(season.seasonNumber!)
            vc.id = String(self.id!)
            vc.showName = showName
            print("peform showseason")
        }
     }


}

extension ShowViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSeasonInfo", sender: nil)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SeasonCollectionViewCell
        //cell.backgroundColor = .red
        let season = seasons[indexPath.item]
        if let posterPath  = season.posterPath{
            cell.seasonPosterImageView.kf.setImage(with: URL(string: imageBaseUrl+posterPath))
            //cell.seasonPosterImageView.image = UIImage(named: "circle")
        }else{
            cell.seasonPosterImageView.image = imageFromText(text: season.name!)
            cell.seasonPosterImageView.contentMode = .scaleAspectFit
            cell.seasonPosterImageView.backgroundColor = .black
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

extension ShowViewController: ResourceObserver {
    func resourceChanged(_ resource: Siesta.Resource, event: ResourceEvent) {
        tvShow = resource.typedContent()
    }


}
