//
//  ProviderViewController.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/4/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit
import Siesta

class ProviderViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    var offers = [Offer]() {
        didSet{
            print(offers.count)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "providerCell", for: indexPath) as! ProviderTableViewCell
        let provider = offers[indexPath.row]
        
        let pattern = #"[l-p]\w\w\w\.\w++|[a-d]\w\w\w[m-o]\w|(?<=\.)\w[^com]\w++|itunes|\w\w\w\w\w\w\w\w\w[l-p]\w|(?<=:\/\/)\w\w\w\w\w[^_]|\w[com]\w\w[m-o]\w|amc"#
        cell.providerNameLabel.text = "Provider \(indexPath.row + 1)"
        print("Urls", provider.urls.standardWeb)
        if let deepLinkURL = provider.urls.deeplinkIos{
            cell.providerURL = deepLinkURL
            print(deepLinkURL)
            if deepLinkURL.contains("nflx"){
                cell.providerNameLabel.text = "Provider: Netflix App"
            }else if deepLinkURL.contains("aiv"){
                cell.providerNameLabel.text = "Provider: Prime Video"
            }
            
            cell.standardWeb = provider.urls.standardWeb
        }else{
            cell.providerURL = provider.urls.standardWeb
            
            var url = URL(string: provider.urls.standardWeb)
            var domain = url!.host!
            domain = domain.regex(pattern: pattern).first ?? ""
            cell.providerNameLabel.text = "Provider: \(domain.capitalizingFirstLetter())"
        }
        
        return cell
        
        
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


extension String {
    func regex (pattern: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
            let nsstr = self as NSString
            let all = NSRange(location: 0, length: nsstr.length)
            var matches : [String] = [String]()
            regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
                (result : NSTextCheckingResult?, _, _) in
                if let r = result {
                    let result = nsstr.substring(with: r.range) as String
                    matches.append(result)
                }
            }
            return matches
        } catch {
            return [String]()
        }
    }
}
