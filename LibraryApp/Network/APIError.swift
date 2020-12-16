//
//  APIError.swift
//  LibraryApp
//
//  Created by Radu Stefan on 15/12/2020.
//

import Foundation


enum APIError: Error
{
    case jsonError
    case nonValidURL
    case badRequest
}

extension APIError: LocalizedError
{
    var errorDescription: String?
    {
        switch self
        {
            case .jsonError:
                return NSLocalizedString("JSON ERROR", comment: "")
            case .nonValidURL:
                return NSLocalizedString("WRONG URL", comment: "")
            case .badRequest:
                return NSLocalizedString("BAD REQUEST", comment: "")
        }
    }
}
