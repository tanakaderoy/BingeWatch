//
//  ShowJWModel.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/4/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let showJWModel = try? newJSONDecoder().decode(ShowJWModel.self, from: jsonData)

import Foundation

// MARK: - ShowJWModel
class ShowJWModel: Codable {
    let  totalResults: Int
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case items
    }

    init(totalResults: Int, items: [Item]) {
        self.totalResults = totalResults
        self.items = items
    }
}

// MARK: - Item
class Item: Codable {
    let jwEntityID: String
    let id: Int
    let title, fullPath: String
    let fullPaths: FullPaths
    let poster: String
    let originalReleaseYear: Int
    let tmdbPopularity: Double
    let objectType: String
    let offers: [Offer]?
    let scoring: [Scoring]

    enum CodingKeys: String, CodingKey {
        case jwEntityID = "jw_entity_id"
        case id, title
        case fullPath = "full_path"
        case fullPaths = "full_paths"
        case poster
        case originalReleaseYear = "original_release_year"
        case tmdbPopularity = "tmdb_popularity"
        case objectType = "object_type"
        case offers = "offers"
        case scoring
    }

    init(jwEntityID: String, id: Int, title: String, fullPath: String, fullPaths: FullPaths, poster: String, originalReleaseYear: Int, tmdbPopularity: Double, objectType: String, offers: [Offer], scoring: [Scoring]) {
        self.jwEntityID = jwEntityID
        self.id = id
        self.title = title
        self.fullPath = fullPath
        self.fullPaths = fullPaths
        self.poster = poster
        self.originalReleaseYear = originalReleaseYear
        self.tmdbPopularity = tmdbPopularity
        self.objectType = objectType
        self.offers = offers
        self.scoring = scoring
    }
}

// MARK: - FullPaths
class FullPaths: Codable {
    let showDetailOverview: String

    enum CodingKeys: String, CodingKey {
        case showDetailOverview = "SHOW_DETAIL_OVERVIEW"
    }

    init(showDetailOverview: String) {
        self.showDetailOverview = showDetailOverview
    }
}

// MARK: - Offer
class Offer: Codable {
    let type, monetizationType: String
    let providerID: Int
    let urls: Urls
    let presentationType: String
    let elementCount, newElementCount: Int
    let dateProviderID, dateCreated: String

    enum CodingKeys: String, CodingKey {
        case type
        case monetizationType = "monetization_type"
        case providerID = "provider_id"
        case urls
        case presentationType = "presentation_type"
        case elementCount = "element_count"
        case newElementCount = "new_element_count"
        case dateProviderID = "date_provider_id"
        case dateCreated = "date_created"
    }

    init(type: String, monetizationType: String, providerID: Int, urls: Urls, presentationType: String, elementCount: Int, newElementCount: Int, dateProviderID: String, dateCreated: String) {
        self.type = type
        self.monetizationType = monetizationType
        self.providerID = providerID
        self.urls = urls
        self.presentationType = presentationType
        self.elementCount = elementCount
        self.newElementCount = newElementCount
        self.dateProviderID = dateProviderID
        self.dateCreated = dateCreated
    }
}

// MARK: - Urls
class Urls: Codable {
    let standardWeb: String
    let deeplinkAndroidTv, deeplinkFireTv, deeplinkTvos: String?

    enum CodingKeys: String, CodingKey {
        case standardWeb = "standard_web"
        case deeplinkAndroidTv = "deeplink_android_tv"
        case deeplinkFireTv = "deeplink_fire_tv"
        case deeplinkTvos = "deeplink_tvos"
    }

    init(standardWeb: String, deeplinkAndroidTv: String, deeplinkFireTv: String, deeplinkTvos: String) {
        self.standardWeb = standardWeb
        self.deeplinkAndroidTv = deeplinkAndroidTv
        self.deeplinkFireTv = deeplinkFireTv
        self.deeplinkTvos = deeplinkTvos
    }
}

// MARK: - Scoring
class Scoring: Codable {
    let providerType: String
    let value: Double

    enum CodingKeys: String, CodingKey {
        case providerType = "provider_type"
        case value
    }

    init(providerType: String, value: Double) {
        self.providerType = providerType
        self.value = value
    }
}
