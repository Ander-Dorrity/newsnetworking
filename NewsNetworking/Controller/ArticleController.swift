//
//  ArticleController.swift
//  NewsNetworking
//
//  Created by Ander Dorrity on 6/10/21.
//

import Foundation

class ArticleController {
    
    static let sharedInstance = ArticleController()
    
    fileprivate let apiKey = "beb2c5bcbc994581b97bec0ea71c1d5d"
    fileprivate let baseURL = URL(string:"https://newsapi.org/v2/")
    
    func fetchArticles(searchText:String, completion: @escaping([Article]?) -> Void) {
        guard let baseURL = baseURL else { completion(nil); return }
        let urlWithPathComponent = baseURL.appendingPathComponent("everything")
        var urlComponents = URLComponents(url: urlWithPathComponent, resolvingAgainstBaseURL: true)
        let queryComponent = URLQueryItem(name: "q", value: "searchText")
        let apiKeyComponent = URLQueryItem(name: "apiKey", value: apiKey)
        urlComponents?.queryItems = [queryComponent, apiKeyComponent]
        guard let finalUrl = urlComponents?.url else { completion(nil); return }
        
        URLSession.shared.dataTask(with: finalUrl) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                    if let fetchedArticles = results.articles  {
                        completion(fetchedArticles)
                    }
                } catch {
                    return
                }
            }
        }.resume()
    }
}
