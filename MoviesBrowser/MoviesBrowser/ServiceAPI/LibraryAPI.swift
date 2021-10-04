//
//  LibraryAPI.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-02.
//

import Foundation

// Needed for Dependency Injection (DI) to the Model Views Class
protocol APIServiceProtocol {
    func downloadMoviesList(completionHandler: @escaping ([Movie], DownloadError) -> ())
    func downloadMovieDetails(forId: Int16, completionHandler: @escaping (Movie?, DownloadError) -> ())
    func downloadRecommendedMovies(forId: Int16, completionHandler: @escaping ([Movie], DownloadError) -> ())
}


// A Singleton
// A Facade pattern
public final class LibraryAPI: APIServiceProtocol {
    
    static let shared = LibraryAPI()
    static let sharedCoreDataHelper:CoreDataMovieServiceProtocol = CoreDataMoviesHelper.shared
    
    private let dataManager:DataMovieSourceManagerProtocol
    private let httpClient = HTTPClient()
    
    private init() {
        self.dataManager = DataSourceManager(sharedCoreDataHelper: Self.sharedCoreDataHelper)
    }
    
    public func downloadMoviesList(completionHandler: @escaping ([Movie], DownloadError) -> ()) {
        self.httpClient.downoadData(urlStr: CONSTACTS.MOVIES_LIST_DATA_URI) { [weak self] (data : Data?, error : DownloadError) in
            
            guard let self = self else { return }
            
            if self.dataManager.parseMovieList(data: data) == .success {
                if let allMovies = Self.sharedCoreDataHelper.fetchMoviesFromStorage() {
                    return completionHandler(allMovies, error)
                }
            }
            
            return completionHandler([], error)
        }
    }
    
    public func downloadMovieDetails(forId: Int16, completionHandler: @escaping (Movie?, DownloadError) -> ()) {
        let uri = String(format: "%@%d.json", CONSTACTS.MOVIE_DETAILS_DATA_URI, forId)
        self.httpClient.downoadData(urlStr: uri) { [weak self] (data : Data?, error : DownloadError) in
            
            guard let self = self else { return }
            
            if self.dataManager.parseMovieDetails(data: data) == .success {
                if let aDetailedMovie = Self.sharedCoreDataHelper.fetchMovieFromStorage(id: forId) {
                    return completionHandler(aDetailedMovie, error)
                }
            }
            
            return completionHandler(nil, error)
        }
    }
    
    public func downloadRecommendedMovies(forId: Int16, completionHandler: @escaping ([Movie], DownloadError) -> ()) {
        let uri = String(format: "%@%d.json", CONSTACTS.MOVIE_RECOMMENDED_LIST_DATA_URI, forId)
        self.httpClient.downoadData(urlStr: uri) { [weak self]  (data : Data?, error : DownloadError) in
            
            guard let self = self else { return }
        
            if self.dataManager.parseMovieRecommended(data: data, movieId: forId) == .success {
                if let movie = Self.sharedCoreDataHelper.fetchMovieFromStorage(id: forId) {
                    if let myRecommendedMovies = movie.recommendedMovies.array as? [Movie] {
                        return completionHandler(myRecommendedMovies, error)
                    }
                }
            }
            
            return completionHandler([], error)
        }
    }
 
}

