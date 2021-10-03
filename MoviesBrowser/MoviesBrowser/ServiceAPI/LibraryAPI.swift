//
//  LibraryAPI.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-02.
//

import Foundation

// A Singleton
// A Facade pattern
public final class LibraryAPI {
    
    static let shared = LibraryAPI()
    
    private let dataManager = DataSourceManager()
    private let httpClient = HTTPClient()
    
    private init() {
       
    }
    
    public func downloadMoviesList(completionHandler: @escaping ([Movie], DownloadError) -> ()) {
        self.httpClient.downoadData(urlStr: CONSTACTS.MOVIES_LIST_DATA_URI) { [weak self] (data : Data?, error : DownloadError) in
            
            guard let self = self else { return }
            
            if self.dataManager.parseMovieList(data: data) == .success {
                if let allMovies = CoreDataMoviesHelper.shared.fetchMoviesFromStorage() {
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
                if let aDetailedMovie = CoreDataMoviesHelper.shared.fetchMovieFromStorage(id: forId) {
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
                if let movie = CoreDataMoviesHelper.shared.fetchMovieFromStorage(id: forId) {
                    if let myRecommendedMovies = movie.recommendedMovies.array as? [Movie] {
                        return completionHandler(myRecommendedMovies, error)
                    }
                }
            }
            
            return completionHandler([], error)
        }
    }
 
}

