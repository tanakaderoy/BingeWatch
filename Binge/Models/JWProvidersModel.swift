//
//  JWProvidersModel.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/27/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//
// MARK: - JWProvider
import Foundation

class JWProvider: Codable {
    let id: Int
    let technicalName, shortName, clearName: String
    let priority, displayPriority: Int
    let monetizationTypes: [MonetizationType]
    let iconURL, slug: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case id
        case technicalName = "technical_name"
        case shortName = "short_name"
        case clearName = "clear_name"
        case priority
        case displayPriority = "display_priority"
        case monetizationTypes = "monetization_types"
        case iconURL = "icon_url"
        case slug, data
    }

    init(id: Int, technicalName: String, shortName: String, clearName: String, priority: Int, displayPriority: Int, monetizationTypes: [MonetizationType], iconURL: String, slug: String, data: DataClass) {
        self.id = id
        self.technicalName = technicalName
        self.shortName = shortName
        self.clearName = clearName
        self.priority = priority
        self.displayPriority = displayPriority
        self.monetizationTypes = monetizationTypes
        self.iconURL = iconURL
        self.slug = slug
        self.data = data
    }
}

// MARK: - DataClass
class DataClass: Codable {
    let deeplinkData: [DeeplinkDatum]
    let packages: Packages

    enum CodingKeys: String, CodingKey {
        case deeplinkData = "deeplink_data"
        case packages
    }

    init(deeplinkData: [DeeplinkDatum], packages: Packages) {
        self.deeplinkData = deeplinkData
        self.packages = packages
    }
}

// MARK: - DeeplinkDatum
class DeeplinkDatum: Codable {
    let scheme: String
    let packages: [String]
    let platforms: [Platform]
    let pathTemplate: String

    enum CodingKeys: String, CodingKey {
        case scheme, packages, platforms
        case pathTemplate = "path_template"
    }

    init(scheme: String, packages: [String], platforms: [Platform], pathTemplate: String) {
        self.scheme = scheme
        self.packages = packages
        self.platforms = platforms
        self.pathTemplate = pathTemplate
    }
}

enum Platform: String, Codable {
    case androidTv = "android_tv"
    case fireTv = "fire_tv"
}

// MARK: - Packages
class Packages: Codable {
    let androidTv, fireTv, tvos: String

    enum CodingKeys: String, CodingKey {
        case androidTv = "android_tv"
        case fireTv = "fire_tv"
        case tvos
    }

    init(androidTv: String, fireTv: String, tvos: String) {
        self.androidTv = androidTv
        self.fireTv = fireTv
        self.tvos = tvos
    }
}

enum MonetizationType: String, Codable {
    case ads = "ads"
    case buy = "buy"
    case cinema = "cinema"
    case flatrate = "flatrate"
    case free = "free"
    case rent = "rent"
}

typealias JWProviders = [JWProvider]
