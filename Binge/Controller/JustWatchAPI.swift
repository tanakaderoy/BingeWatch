//
//  JustWatchAPI.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 1/20/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

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
