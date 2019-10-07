//
//  TvShowModel.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/3/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tvShowModel = try? newJSONDecoder().decode(TvShowModel.self, from: jsonData)

import Foundation

// MARK: - TvShowModel
class TvShowModel: Codable {
    let backdropPath: String?
    let createdBy: [CreatedBy]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let lastEpisodeToAir: LastEpisodeToAir?
    let name: String?
//    let nextEpisodeToAir: JSONNull?
    let networks: [Network]?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [Network]?
    let seasons: [Season]?
    let status, type: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
//        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case seasons, status, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(backdropPath: String?, createdBy: [CreatedBy]?, episodeRunTime: [Int]?, firstAirDate: String?, genres: [Genre]?, homepage: String?, id: Int?, inProduction: Bool?, languages: [String]?, lastAirDate: String?, lastEpisodeToAir: LastEpisodeToAir?, name: String?, networks: [Network]?, numberOfEpisodes: Int?, numberOfSeasons: Int?, originCountry: [String]?, originalLanguage: String?, originalName: String?, overview: String?, popularity: Double?, posterPath: String?, productionCompanies: [Network]?, seasons: [Season]?, status: String?, type: String?, voteAverage: Double?, voteCount: Int?) {
        self.backdropPath = backdropPath
        self.createdBy = createdBy
        self.episodeRunTime = episodeRunTime
        self.firstAirDate = firstAirDate
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.inProduction = inProduction
        self.languages = languages
        self.lastAirDate = lastAirDate
        self.lastEpisodeToAir = lastEpisodeToAir
        self.name = name
//        self.nextEpisodeToAir = nextEpisodeToAir
        self.networks = networks
        self.numberOfEpisodes = numberOfEpisodes
        self.numberOfSeasons = numberOfSeasons
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.seasons = seasons
        self.status = status
        self.type = type
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

// MARK: - CreatedBy
class CreatedBy: Codable {
    let id: Int?
    let creditID, name, profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name
        case profilePath = "profile_path"
    }

    init(id: Int?, creditID: String?, name: String?, profilePath: String?) {
        self.id = id
        self.creditID = creditID
        self.name = name
        self.profilePath = profilePath
    }
}

// MARK: - Genre
class Genre: Codable {
    let id: Int?
    let name: String?

    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: - LastEpisodeToAir
class LastEpisodeToAir: Codable {
    let airDate: String?
    let episodeNumber, id: Int?
    let name, overview, productionCode: String?
    let seasonNumber, showID: Int?
    let stillPath: String?
    let voteAverage: Double?
    let voteCount: Int?

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
    }

    init(airDate: String?, episodeNumber: Int?, id: Int?, name: String?, overview: String?, productionCode: String?, seasonNumber: Int?, showID: Int?, stillPath: String?, voteAverage: Double?, voteCount: Int?) {
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
    }
}

// MARK: - Network
class Network: Codable {
    let name: String?
    let id: Int?
    let logoPath: String?
    let originCountry: String?

    enum CodingKeys: String, CodingKey {
        case name, id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }

    init(name: String?, id: Int?, logoPath: String?, originCountry: String?) {
        self.name = name
        self.id = id
        self.logoPath = logoPath
        self.originCountry = originCountry
    }
}

// MARK: - Season
class Season: Codable {
    let airDate: String?
    let episodeCount, id: Int?
    let name, overview, posterPath: String?
    let seasonNumber: Int?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }

    init(airDate: String?, episodeCount: Int?, id: Int?, name: String?, overview: String?, posterPath: String?, seasonNumber: Int?) {
        self.airDate = airDate
        self.episodeCount = episodeCount
        self.id = id
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.seasonNumber = seasonNumber
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
