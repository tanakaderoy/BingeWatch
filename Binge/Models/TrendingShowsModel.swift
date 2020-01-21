//
//  TrendingShowsModel.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/1/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let trendingShowsModel = try? newJSONDecoder().decode(TrendingShowsModel.self, from: jsonData)

import Foundation

// MARK: - TrendingShowsModel
class TrendingShowsModel: Codable {
    let page: Int
    let results: [TvShowResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(page: Int, results: [TvShowResult], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

// MARK: - Result
class TvShowResult: Codable, CustomStringConvertible {
    let originalName: String
    let id: Int
    let name: String
    let voteCount: Int
    let voteAverage: Double
    let firstAirDate, posterPath: String
    let genreIDS: [Int]
    let originalLanguage, backdropPath, overview: String
    let originCountry: [String]
    let popularity: Double
    let mediaType: String

    var description : String {
        var description = ""
        description += "name: \(self.originalName)"
        return description
    }

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case id, name
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case overview
        case originCountry = "origin_country"
        case popularity
        case mediaType = "media_type"
    }

    init(originalName: String, id: Int, name: String, voteCount: Int, voteAverage: Double, firstAirDate: String, posterPath: String, genreIDS: [Int], originalLanguage: String, backdropPath: String, overview: String, originCountry: [String], popularity: Double, mediaType: String) {
        self.originalName = originalName
        self.id = id
        self.name = name
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.firstAirDate = firstAirDate
        self.posterPath = posterPath
        self.genreIDS = genreIDS
        self.originalLanguage = originalLanguage
        self.backdropPath = backdropPath
        self.overview = overview
        self.originCountry = originCountry
        self.popularity = popularity
        self.mediaType = mediaType
    }
}
