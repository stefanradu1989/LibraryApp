//
//  URLBuilder.swift
//  LibraryApp
//
//  Created by Radu Stefan on 15/12/2020.
//

import Foundation


struct APIPath
{
    static let scheme = "https"
    static let baseURL = "jsonmock.hackerrank.com"
}

struct Endpoint
{
    let path: String
    let queryItems: [URLQueryItem]?
}

extension Endpoint
{
    var url: URL?
    {
        var components = URLComponents()
        components.scheme = APIPath.scheme
        components.host = APIPath.baseURL
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}
