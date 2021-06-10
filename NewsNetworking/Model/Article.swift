//
//  Article.swift
//  NewsNetworking
//
//  Created by Ander Dorrity on 6/10/21.
//

import Foundation

struct TopLevelDictionary: Decodable {
    
    let articles: [Article]?
    
}

struct Article: Decodable {
    
    let title: String?
    let url: URL?
    
}
