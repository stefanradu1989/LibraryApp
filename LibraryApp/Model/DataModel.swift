//
//  DataModel.swift
//  LibraryApp
//
//  Created by Radu Stefan on 15/12/2020.
//

import Foundation


class DataModel: Decodable
{
    let page: String
    let per_page: Int
    let total: Int
    let total_pages: Int
    
    let data: [BookModel]
}


class BookModel: Decodable
{
    var title: String?
    var author: String
    var story_title: String?
}


struct LibraryRow
{
    var author: String
    var numberOfBooks: Int
    var isEven: String {
        if numberOfBooks % 2 == 0
        {
            return "*"
        }
        else
        {
            return ""
        }
    }
}
