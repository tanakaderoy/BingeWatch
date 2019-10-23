//
//  ShowSearchModel.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/2/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let showSearchModel = try? newJSONDecoder().decode(ShowSearchModel.self, from: jsonData)

import Foundation

// MARK: - ShowSearchModel
class ShowSearchModel: Codable {
    let page, totalResults, totalPages: Int
    let results: [ShowSearchResult]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    init(page: Int, totalResults: Int, totalPages: Int, results: [ShowSearchResult]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}

// MARK: - Result
class ShowSearchResult: Codable {
    let originalName: String
    let genreIDS: [Int]
    let name: String
    let popularity: Double
    let originCountry: [String]
    let voteCount: Int
    let originalLanguage: String
    let backdropPath,firstAirDate , posterPath: String?
    let id: Int
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
    
    init(originalName: String, genreIDS: [Int], name: String, popularity: Double, originCountry: [String], voteCount: Int, firstAirDate: String, backdropPath: String, originalLanguage: String, id: Int, voteAverage: Double, overview: String, posterPath: String) {
        self.originalName = originalName
        self.genreIDS = genreIDS
        self.name = name
        self.popularity = popularity
        self.originCountry = originCountry
        self.voteCount = voteCount
        self.firstAirDate = firstAirDate
        self.backdropPath = backdropPath
        self.originalLanguage = originalLanguage
        self.id = id
        self.voteAverage = voteAverage
        self.overview = overview
        self.posterPath = posterPath
    }
}
