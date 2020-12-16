//
//  ViewModel.swift
//  LibraryApp
//
//  Created by Radu Stefan on 15/12/2020.
//

import Foundation


private enum Const
{
    static let path: String = "/api/articles"
    static let page: String = "page"
    static let author: String = "author"
    static let na: String = "NA"
    static let newLine:String = "\n"
}


class ViewModel
{
    var nrOfPages = 0
    
    var rows: [LibraryRow] = []
    let service = GenericServiceImplementation()
    
    
    //MARK: Network
    
    func getBooks(pageNumber: String, completion: @escaping (DataModel?, APIError?) -> Void)
    {
        let endpoint: Endpoint = Endpoint(path: Const.path, queryItems: [URLQueryItem(name: Const.page, value: pageNumber)])
        
        if let endpointURL = endpoint.url
        {
            service.getGenericData(url: endpointURL, completion: {(dataModel: DataModel?, error: APIError?) in
                completion(dataModel, error)
            })
        }
    }
    
    func getBooksForAuthor(pageNumber: String, author: String, completion: @escaping (DataModel?, APIError?) -> Void)
    {
        let endpoint: Endpoint = Endpoint(path: Const.path, queryItems: [URLQueryItem(name: Const.page, value: pageNumber), URLQueryItem(name: Const.author, value: author)])
        
        if let endpointURL = endpoint.url
        {
            service.getGenericData(url: endpointURL, completion: {(dataModel: DataModel?, error: APIError?) in
                completion(dataModel, error)
            })
        }
    }
    
    
    //MARK: Helpers
    
    func updateData(data: DataModel)
    {
        nrOfPages = data.total_pages
        
        for author in getAuthors(books: data.data)
        {
            let numberOfBooks = getBooksByAuthor(author: author, books: data.data)
            
            var newAuthor = true
            
            for item in rows
            {
                if author == item.author
                {
                    newAuthor = false
                }
            }
            
            if newAuthor
            {
                rows.append(LibraryRow(author: author, numberOfBooks: numberOfBooks))
            }
        }
    }
    
    func getAuthors(books: [BookModel]) -> [String]
    {
        let authors = books.map { $0.author }
        
        let unique = Array(Set(authors))
        
        return unique
    }
    
    func getBooksByAuthor(author: String, books: [BookModel]) -> Int
    {
        let booksByAuthor = books.filter { $0.author == author }
        
        return booksByAuthor.count
    }
    
    func getBooksByAuthorString(booksString: String, data: DataModel) -> String
    {
        var newString = booksString
        
        for item in data.data
        {
            newString += "- "
            
            if let title = item.title
            {
                newString += title
            }
            else if let storyTtile = item.story_title
            {
                newString += storyTtile
            }
            else
            {
                newString += Const.na
            }
            
            newString += Const.newLine
        }
        
        return newString
    }
}
