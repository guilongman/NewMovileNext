//
//  TraktHTTPClient.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Alamofire
import Result
import TraktModels
import Argo

class TraktHTTPClient {
    
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"] = "application/json"
            headers["trakt-api-key"] = "0e8ba0b2b99aa3ca11348dea4c7053850f644afc1049a34054bff57f02e3f1d5"
            headers["trakt-api-version"] = "2"
            // ...
            configuration.HTTPAdditionalHeaders = headers
            return configuration
        }()
        return Manager(configuration: configuration)
    }()
    
    private func getJSONElement<T: Decodable where T.DecodedType == T>(router: Router, completion: ((Result<T, NSError?>) -> Void)?){
        manager.request(router).validate().responseJSON { (_, _, jsonResponse, error) in
            if let jsonData = jsonResponse as? NSDictionary
            {
                let decoded = T.decode(JSON.parse(jsonData))
                
                if let value = decoded.value
                {
                    completion?(Result.success(value))
                }
                else
                {
                    completion?(Result.failure(nil))
                }
            }
            else
            {
                completion?(Result.failure(error))
            }
        }
    }
    
    private func getJSONElements<T: Decodable where T.DecodedType == T>(router: Router, completion: ((Result<[T], NSError?>) -> Void)?){
        manager.request(router).validate().responseJSON { (_, _, jsonResponse, error) in
            if let jsonData = jsonResponse as? [NSDictionary]
            {
//                let elements : [T] = []
                let elements = jsonData.map { T.decode(JSON.parse($0)).value }.filter { $0 != nil }.map { $0! }
                completion?(Result.success(elements))
                //codigo acima é a mesma implementação do código abaixo
                //primeiro map, faz o decode do valor
                //filter remove valores nulos
                //segundo map, faz o unwrape dos elementos
//                
//                for i in 0...jsonData.count-1
//                {
//                    let decoded = T.decode(JSON.parse(jsonData[i]))
//                    if let value = decoded.value
//                    {
//                        elements.append(value)
//                    }
//                    else
//                    {
//                        completion?(Result.failure(nil))
//                    }
//                }
//                
//                completion?(Result.success(elements))
            }
            else
            {
                completion?(Result.failure(error))
            }
        }
    }
    
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)? = nil)
    {
        let router = Router.Show(id)
        getJSONElement(router, completion: completion)
    }
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)? = nil)
    {
        let router = Router.Episode(showId, season, episodeNumber)
        getJSONElement(router, completion: completion)
    }
    
    func getPopularShows(completion: ((Result<Array<Show>, NSError?>) -> Void)?) {
        let router = Router.PopularShows()
        getJSONElements(router, completion: completion)
    }
    
    func getSeasons(showId: String, completion: ((Result<Array<Season>, NSError?>) -> Void)?) {
        let router = Router.Seasons(showId)
        getJSONElements(router, completion: completion)
    }
    
    func getEpisodes(showId: String, season: Int, completion: ((Result<Array<Episode>, NSError?>) -> Void)?) {
        let router = Router.Episodes(showId, season)
        getJSONElements(router, completion: completion)
    }
    
}

private enum Router: URLRequestConvertible {
    static let baseURLString = "https://api-v2launch.trakt.tv/"
    
    case Show(String)
    case Episode(String, Int, Int)
    case PopularShows()
    case Seasons(String)
    case Episodes(String, Int)
    
    
    // MARK: URLRequestConvertible
    var URLRequest: NSURLRequest {
        let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
        switch self {
    case .Show(let id):
        return ("shows/\(id)", ["extended": "images,full"], .GET)
    case .Episode(let id, let season, let episodeNumber):
        return ("shows/\(id)/seasons/\(season)/episodes/\(episodeNumber)", ["extended": "images,full"], .GET)
    case .PopularShows():
        return ("shows/popular", ["extended": "images,full"], .GET)
    case .Seasons(let showId):
            return ("shows/\(showId)/seasons", ["extended": "images,full"], .GET)
    case .Episodes(let showId, let season):
        return ("shows/\(showId)/seasons/\(season)", ["extended": "images,full"], .GET)
        }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        URLRequest.HTTPMethod = method.rawValue
        let encoding = Alamofire.ParameterEncoding.URL
        return encoding.encode(URLRequest, parameters: parameters).0
    }
}