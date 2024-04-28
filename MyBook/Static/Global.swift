//
//  Global.swift
//  MyBook
//
//  Created by Yernur Adilbek on 3/29/24.
//

import Foundation

struct BookSubjects {
    static let adventure = "adventure"
    static let fantasy = "fantasy"
    static let health = "health"
    static let horror = "horror"
}

struct Global {
    struct APIs {
        struct URLs {
            struct GBA {
                static func nowPlaying(subject: String, maxResults: Int) -> String {
                    return "https://www.googleapis.com/books/v1/volumes?q=subject:\(subject)&maxResults=\(maxResults)&key=\(Global.APIs.Keys.gba)"
                }
                
                static func search(searchInput: String) -> String {
                    return "https://www.googleapis.com/books/v1/volumes?q=\(searchInput)&maxResults=10&key=\(Global.APIs.Keys.gba)"
                }
                
                static func createImageUrl(_ path: String) -> URL? {
                    URL(string: "\(path)")
                }
            }
        }
        struct Keys {
            static let gba = "AIzaSyAHqzfo4wOy9MVwZDxpmI-wAWtC6CpbDM0"
        }
    }
}
