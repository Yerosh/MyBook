//
//  BookManager.swift
//  MyBook
//
//  Created by Yernur Adilbek on 3/29/24.
//

import Foundation

struct BookManager {
    
    weak var delegate: FetchBooksDelegate?
    
    func fetchAdventureBooks(maxResults: Int) {
        let urlString = Global.APIs.URLs.GBA.nowPlaying(subject: BookSubjects.adventure, maxResults: maxResults)
        fetchData(with: urlString)
    }
        
    func fetchFantasyBooks(maxResults: Int) {
        let urlString = Global.APIs.URLs.GBA.nowPlaying(subject: BookSubjects.fantasy, maxResults: maxResults)
        fetchData(with: urlString)
    }
    
    func fetchHorrorBooks(maxResults: Int) {
        let urlString = Global.APIs.URLs.GBA.nowPlaying(subject: BookSubjects.horror, maxResults: maxResults)
        fetchData(with: urlString)
    }
    
    func fetchHealthBooks(maxResults: Int) {
        let urlString = Global.APIs.URLs.GBA.nowPlaying(subject: BookSubjects.health, maxResults: maxResults)
        fetchData(with: urlString)
    }
    
    func fetchSearchInput(searchInput: String) {
        let urlString = Global.APIs.URLs.GBA.search(searchInput: searchInput)
        fetchData(with: urlString)
    }
    
    func fetchData(with urlString: String) {
//        let urlString = "\(Global.APIs.URLs.TMDB.nowPlaying)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data, error == nil {
                if let model = parseJSON(data) {
                    delegate?.didUpdateBooks(with: model.items)
                }
            } else {
                delegate?.didFailWithError(error!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data) -> BookData? {
        do {
            let decodedData = try JSONDecoder().decode(BookData.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}


protocol FetchBooksDelegate: AnyObject {
    func didUpdateBooks(with results: [BookData.Item])
    func didFailWithError(_ error: Error)
}
