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
    let totalResults: Int
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
    let poster: String?
    let originalReleaseYear: Int?
    let tmdbPopularity: Double?
    let objectType, originalTitle: String
    let offers: [Offer]?
    let scoring: [Scoring]?
    let originalLanguage: String?
    let ageCertification, shortDescription: String?
    let maxSeasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case jwEntityID = "jw_entity_id"
        case id, title
        case fullPath = "full_path"
        case fullPaths = "full_paths"
        case poster
        case shortDescription = "short_description"
        case originalReleaseYear = "original_release_year"
        case tmdbPopularity = "tmdb_popularity"
        case objectType = "object_type"
        case originalTitle = "original_title"
        case offers, scoring
        case originalLanguage = "original_language"
        case ageCertification = "age_certification"
        case maxSeasonNumber = "max_season_number"
    }

    init(jwEntityID: String, id: Int, title: String, fullPath: String, fullPaths: FullPaths, poster: String?, shortDescription: String?, originalReleaseYear: Int?, tmdbPopularity: Double?, objectType: String, originalTitle: String, offers: [Offer]?, scoring: [Scoring]?, originalLanguage: String?, ageCertification: String?, maxSeasonNumber: Int) {
        self.jwEntityID = jwEntityID
        self.id = id
        self.title = title
        self.fullPath = fullPath
        self.fullPaths = fullPaths
        self.poster = poster
        self.shortDescription = shortDescription
        self.originalReleaseYear = originalReleaseYear
        self.tmdbPopularity = tmdbPopularity
        self.objectType = objectType
        self.originalTitle = originalTitle
        self.offers = offers
        self.scoring = scoring
        self.originalLanguage = originalLanguage
        self.ageCertification = ageCertification
        self.maxSeasonNumber = maxSeasonNumber
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
    let currency: String?
    let urls: Urls
    let presentationType: String
    let elementCount, newElementCount: Int
    let dateCreatedProviderID, dateCreated, country: String

    enum CodingKeys: String, CodingKey {
        case type
        case monetizationType = "monetization_type"
        case providerID = "provider_id"
        case currency, urls
        case presentationType = "presentation_type"
        case elementCount = "element_count"
        case newElementCount = "new_element_count"
        case dateCreatedProviderID = "date_created_provider_id"
        case dateCreated = "date_created"
        case country
    }

    init(type: String, monetizationType: String, providerID: Int, currency: String?, urls: Urls, presentationType: String, elementCount: Int, newElementCount: Int, dateCreatedProviderID: String, dateCreated: String, country: String) {
        self.type = type
        self.monetizationType = monetizationType
        self.providerID = providerID
        self.currency = currency
        self.urls = urls
        self.presentationType = presentationType
        self.elementCount = elementCount
        self.newElementCount = newElementCount
        self.dateCreatedProviderID = dateCreatedProviderID
        self.dateCreated = dateCreated
        self.country = country
    }
}

// MARK: - Urls
class Urls: Codable {
    let standardWeb: String
    let deeplinkAndroid, deeplinkIos: String?
    let deeplinkAndroidTv: String?

    enum CodingKeys: String, CodingKey {
        case standardWeb = "standard_web"
        case deeplinkAndroid = "deeplink_android"
        case deeplinkIos = "deeplink_ios"
        case deeplinkAndroidTv = "deeplink_android_tv"
    }

    init(standardWeb: String, deeplinkAndroid: String?, deeplinkIos: String?, deeplinkAndroidTv: String?) {
        self.standardWeb = standardWeb
        self.deeplinkAndroid = deeplinkAndroid
        self.deeplinkIos = deeplinkIos
        self.deeplinkAndroidTv = deeplinkAndroidTv
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
