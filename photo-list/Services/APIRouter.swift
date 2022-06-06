//
//  APIRouter.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import Foundation

/// HTTP Method typs (only the basics)
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - RouteConfig

protocol RouteConfig {
    typealias HeaderParams = [String: Any]
    typealias APIParams = [String: String]
    
    var method: HTTPMethod { get }
    var baseURLString: String { get }
    var path: String { get }
    var headers: HeaderParams { get }
    var params: APIParams { get }
    
    func asURLRequest() -> URLRequest?
}

extension RouteConfig {
    
    var baseURLString: String {
        return "https://jsonplaceholder.typicode.com/" // Put in a constants file
    }
    
    // a default extension that creates the full URL
    var url: String {
        return baseURLString + path
    }
    
    var headers: HeaderParams {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    func asURLRequest() -> URLRequest? {
        var urlString = self.url
        if method == .get, !params.isEmpty {
            let urlComp = NSURLComponents(string: self.url)!
            var items = [URLQueryItem]()
            
            for (key,value) in params {
                items.append(URLQueryItem(name: key, value: value))
            }
            
            items = items.filter{!$0.name.isEmpty}
            
            if !items.isEmpty {
                urlComp.queryItems = items
            }
            urlString = urlComp.url!.absoluteString
        }
        
        // URL
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Header fields
        headers.forEach({ header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        
        return urlRequest
    }
}

// MARK: - Routes

enum APIRouter: RouteConfig {
    
    // MARK: - API Routes
    case getPhotos
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos: return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPhotos: return "photos"
        }
    }
    
    var params: APIParams {
        switch self {
        default: return [:]
        }
    }
    
}

