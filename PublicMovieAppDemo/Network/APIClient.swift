//
//  APIClient.swift
//  PublicMovieAppDemo
//
//  Created by Shashank Saini on 30/07/24.
//

import Alamofire

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response.result)
        }
    }
    
    static func getAllMovies(completion:@escaping (Result<Movie, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.movieDateFormatter)
        performRequest(route: APIRouter.movieList, decoder: jsonDecoder, completion: completion)
    }
    
    static func searchMovie(query: String, completion:@escaping (Result<Movie, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.movieDateFormatter)
        performRequest(route: APIRouter.searchMovie(query: query), decoder: jsonDecoder, completion: completion)
    }
    
    static func getMovieDetails(id: String, completion:@escaping (Result<Results, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.movieDateFormatter)
        performRequest(route: APIRouter.movieDetail(id: id), decoder: jsonDecoder, completion: completion)
    }
    
}
