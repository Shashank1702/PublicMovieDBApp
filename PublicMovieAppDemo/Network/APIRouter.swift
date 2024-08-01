//
//  APIRouter.swift
//  PublicMovieAppDemo
//
//  Created by Shashank Saini on 30/07/24.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case searchMovie(query:String)
    case movieList
    case movieDetail(id: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .movieList, .movieDetail, .searchMovie:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .searchMovie(let query):
            return "/search/movie?query=\(query)"
        case .movieList:
            return "/movie/now_playing"
        case .movieDetail(let movie_id):
            return "/movie/\(movie_id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .movieList, .movieDetail, .searchMovie:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try (ServerUrls.demoServer.baseURL + path).asURL()
        
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(APIAccessToken, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
