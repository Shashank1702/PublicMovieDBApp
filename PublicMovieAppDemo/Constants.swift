//
//  Constants.swift
//  NetworkLayerSetup
//
//  Created by Shashank Saini on 30/07/24.
//

import Foundation

let APIKey = "a2e16700ca42b4f66f6dd8e8deda5aca"
let APIAccessToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMmUxNjcwMGNhNDJiNGY2NmY2ZGQ4ZThkZWRhNWFjYSIsIm5iZiI6MTcyMjMxOTc2Mi4xNjgwOTgsInN1YiI6IjY2YTg4Mjk5YWJlOGVhZjEyZWQ3YzljMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.sEQQqK--YE2co6Bdvqe7KRiVHrMhkl0NB5UQI9I-zk4"

struct ServerUrls {
    struct demoServer {
        static let baseURL = "https://api.themoviedb.org/3"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

extension DateFormatter {
    static var movieDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}
