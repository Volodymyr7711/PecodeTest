//
//  APIService.swift
//  PecodeTest
//
//  Created by Volodymyr Mendyk on 08.04.2021.
//

import Foundation
import UIKit

class Service {
    
    func parse(data: Data) -> [Article] {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(NewsResult.self, from: data)
            return result.articles
        } catch {
            print("Parsing Error: \(error.localizedDescription)")
            return []
        }
    }
    
    func newsURL(searchText: String, category: Int, country: Int) -> URL? {
        
        let categoryKind: String
        let countryKind: String
        
        let baseUrl = "https://newsapi.org/"
        let title = "top-headlines"
        let apiKey = "c4a5aefd474b42069c588527578ffa4a"
        
        switch category {
        case 0: categoryKind = "health"
        case 1: categoryKind = "business"
        case 2: categoryKind = "science"
        default: categoryKind = ""
        }
        
        switch country {
        case 0: countryKind = "us"
        case 1: countryKind = "ua"
        case 2: countryKind = "de"
        default: countryKind = ""
        }
        
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "\(baseUrl)v2/\(title)?q=\(encodedText!)&category=\(categoryKind)&country=\(countryKind)&sortBy=publishedAt&apiKey=\(apiKey)"
        
        return URL(string: urlString)
        
    }
}

 
