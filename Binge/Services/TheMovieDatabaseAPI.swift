//
//  TheMovieDatabaseAPI.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/1/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved..
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

