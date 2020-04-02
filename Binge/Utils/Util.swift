//
//  Util.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/18/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation
let imageBaseURLChooseSize = "https://image.tmdb.org/t/p/"
let imageBaseUrl = "https://image.tmdb.org/t/p/w500"

func getYearFromDateString(dateString:String) -> String{
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "yyyy"
    if let date = dateFormatterGet.date(from: dateString){
        return dateFormatterPrint.string(from: date)
    }
    return "N/A"
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
