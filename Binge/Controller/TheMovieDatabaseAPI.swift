//
//  TheMovieDatabaseAPI.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/1/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import Siesta
import SwiftyJSON

class TMDBAPI {
    static let sharedInstance = TMDBAPI()
    private let service  = Service(baseURL: "https://api.themoviedb.org/3", standardTransformers: [.text, .image])
    private let apiKey = "a5968df59cc3e43725bcb8d5a89aa34c"
    private init() {
        SiestaLog.Category.enabled = .common
        let jsonDecoder = JSONDecoder()

        service.configureTransformer("/trending/tv/week") {
            try jsonDecoder.decode(TrendingShowsModel.self, from: $0.content).results

        }
        service.configureTransformer("/search/tv"){
            try jsonDecoder.decode(ShowSearchModel.self, from: $0.content).results
        }
        service.configureTransformer("/tv/*"){
            try jsonDecoder.decode(TvShowModel.self, from: $0.content)
        }

        service.configureTransformer("/tv/*/season/*"){
            try jsonDecoder.decode(SeasonModel.self, from: $0.content)
        }
    }
    func getSeasonInfo(showId id:String, seasonNumber num:String) -> Resource{
        return service
            .resource("/tv")
            .child(id)
            .child("/season")
            .child(num)
            .withParam("api_key", apiKey)
    }
    func getEpisode(showId id: String, season: String, episodeNumber: String) -> Resource {
        return service
            .resource("/tv")
            .child(id)
            .child("/season")
            .child(season)
            .child("/episode")
            .child(episodeNumber)
            .withParam("api_key", apiKey)
    }

    func getShow(showId id: String) -> Resource{
        return service
            .resource("/tv")
            .child(id)
            .withParam("api_key", apiKey)

    }
    

    func getTrendingShows() -> Resource {
        return service
            .resource("/trending/tv/week")
            .withParam("api_key", apiKey)
    }
    func searchWithQuery(searchQuery query: String) -> Resource {
        let result = service
            .resource("/search/tv")
            .withParam("api_key", apiKey)
            .withParam("query", query)
        return result
    }
}

class JustWatchAPI {
    static let sharedInstance = JustWatchAPI()
    private let service = Service(baseURL: "https://apis.justwatch.com", standardTransformers: [.text, .image])
    private init() {
        LogCategory.enabled = [.network, .pipeline, .observers]
        service.configure("**"){
            $0.headers["Content-Type"] = "application/json"
        }
        let jsonDecoder = JSONDecoder()
        service.configureTransformer("content/titles/en_US/popular"){
            try jsonDecoder.decode(ShowJWModel.self, from: $0.content)
        }


    }

    func searchForShow(showName name:String) -> Request? {

        let json = JSON.init(parseJSON: "{\"content_types\":[\"show\"],\"query\":\"\(name)\",\"page\":null,\"page_size\":null}")
        var bodyParam: Data?
        do {
            try bodyParam = json.rawData()
        } catch let error {
            print(error)
        }
        guard let body = bodyParam else{return nil}
        return service
            .resource("content/titles/en_US/popular").request(.post, data: body, contentType: "application/json")

    }
}
// class YelpAPI {
//
//  static let sharedInstance = YelpAPI()
//
//  private let service = Service(baseURL: "https://api.yelp.com/v3", standardTransformers: [.text, .image])
//
//  private init() {
//
//    LogCategory.enabled = [.network, .pipeline, .observers]
//
//    service.configure("**") {
//      $0.headers["Authorization"] =
//      "Bearer B6sOjKGis75zALWPa7d2dNiNzIefNbLGGoF75oANINOL80AUhB1DjzmaNzbpzF-b55X-nG2RUgSylwcr_UYZdAQNvimDsFqkkhmvzk6P8Qj0yXOQXmMWgTD_G7ksWnYx"
//      $0.expirationTime = 60 * 60
//    }
//
//    let jsonDecoder = JSONDecoder()
//
//    service.configureTransformer("/businesses/*") {
//      try jsonDecoder.decode(RestaurantDetails.self, from: $0.content)
//    }
//
//    service.configureTransformer("/businesses/search") {
//      try jsonDecoder.decode(SearchResults<Restaurant>.self, from: $0.content).businesses
//    }
//  }
//
//  func restaurantList(for location: String) -> Resource {
//    return service
//      .resource("/businesses/search")
//      .withParam("term", "pizza")
//      .withParam("location", location)
//  }
//
//  func restaurantDetails(_ id: String) -> Resource {
//    return service
//      .resource("/businesses")
//      .child(id)
//  }
//}

