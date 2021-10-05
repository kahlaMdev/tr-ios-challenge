//
//  ApiProtocol.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation

public enum DownloadError {
    case noError
    case invalidResponse
    case missingData
    case requestError
}

enum DataProcessingState {
    case fail
    case success
}

// Needed for Dependency Injection (DI) to the Model Views Class

public protocol APIServiceProtocol {
    func downloadMoviesList(completionHandler: @escaping ([MovieProtocol], DownloadError) -> ())
    func downloadMovieDetails(forId: Int16, completionHandler: @escaping (MovieProtocol?, DownloadError) -> ())
    func downloadRecommendedMovies(forId: Int16, completionHandler: @escaping ([MovieProtocol], DownloadError) -> ())
    func getFromStorageRecommendedMovies(forId: Int16) -> [MovieProtocol]
    func getMoviesFromStorage() -> [MovieProtocol]
}

protocol DataMovieSourceManagerProtocol {
    init(sharedCoreDataHelper:CoreDataMovieServiceProtocol)
    func parseMovieList(data: Data?) -> DataProcessingState
    func parseMovieDetails(data: Data?) -> DataProcessingState
    func parseMovieRecommended(data: Data?, movieId: Int16) -> DataProcessingState
}

