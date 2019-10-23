//
//  SeasonModel.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/3/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let seasonModel = try? newJSONDecoder().decode(SeasonModel.self, from: jsonData)

import Foundation

// MARK: - SeasonModel
class SeasonModel: Codable {
    let id, airDate: String?
    let episodes: [Episode]
    let name, overview: String?
    let seasonModelID: Int?
    let posterPath: String?
    let seasonNumber: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case seasonModelID = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
    
    init(id: String?, airDate: String?, episodes: [Episode], name: String?, overview: String?, seasonModelID: Int?, posterPath: String?, seasonNumber: Int?) {
        self.id = id
        self.airDate = airDate
        self.episodes = episodes
        self.name = name
        self.overview = overview
        self.seasonModelID = seasonModelID
        self.posterPath = posterPath
        self.seasonNumber = seasonNumber
    }
}

// MARK: - Episode
class Episode: Codable {
    let airDate: String?
    let episodeNumber, id: Int?
    let name, overview, productionCode: String?
    let seasonNumber, showID: Int?
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let crew: [Crew]?
    let guestStars: [GuestStar]?
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id, name, overview
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case crew
        case guestStars = "guest_stars"
    }
    
    init(airDate: String?, episodeNumber: Int?, id: Int?, name: String?, overview: String?, productionCode: String?, seasonNumber: Int?, showID: Int?, stillPath: String?, voteAverage: Double?, voteCount: Int?, crew: [Crew]?, guestStars: [GuestStar]?) {
        self.airDate = airDate
        self.episodeNumber = episodeNumber
        self.id = id
        self.name = name
        self.overview = overview
        self.productionCode = productionCode
        self.seasonNumber = seasonNumber
        self.showID = showID
        self.stillPath = stillPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.crew = crew
        self.guestStars = guestStars
    }
}

// MARK: - Crew
class Crew: Codable {
    let id: Int?
    let creditID, name, department, job: String?
    //let profilePath: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, department, job
        // case profilePath = "profile_path"
    }
    
    init(id: Int?, creditID: String?, name: String?, department: String?, job: String?) {
        self.id = id
        self.creditID = creditID
        self.name = name
        self.department = department
        self.job = job
        //        self.profilePath = profilePath
    }
}

// MARK: - GuestStar
class GuestStar: Codable {
    let id: Int?
    let name, creditID, character: String?
    let order, gender: Int?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case creditID = "credit_id"
        case character, order, gender
        case profilePath = "profile_path"
    }
    
    init(id: Int?, name: String?, creditID: String?, character: String?, order: Int?, gender: Int?, profilePath: String?) {
        self.id = id
        self.name = name
        self.creditID = creditID
        self.character = character
        self.order = order
        self.gender = gender
        self.profilePath = profilePath
    }
}
