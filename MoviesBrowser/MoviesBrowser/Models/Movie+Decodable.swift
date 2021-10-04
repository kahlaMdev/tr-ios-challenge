//
//  Movie+Decodable.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-02.
//

import Foundation

// MARK: - Decodable Movie Structs based on json 

public struct MoviesList: Decodable {
    let movies: [MovieModel]
}

public struct MovieDetail: Decodable {
    let identifier: Int16
    let name: String
    let descript: String
    let plot: String
    let rating: Float
    let picture: String
    let releaseDateEpochTime: Int64
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case descript = "Description"
        case releaseDateEpochTime = "releaseDate"
        case plot = "Notes"
        case picture
        case rating = "Rating"
    }
}

public struct MovieModel: Decodable {
    let identifier: Int16
    let name: String
    let thumbnail: String
    let year: Int16
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case thumbnail
        case year
    }
}
