//
//  LibraryAPI.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-02.
//

import Foundation

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
    
    public func downloadMoviesList(completionHandler: @escaping ([MovieProtocol], DownloadError) -> ()) {
        self.httpClient.downoadData(urlStr: CONSTACTS.MOVIES_LIST_DATA_URI) { [weak self] (data : Data?, error : DownloadError) in
            
            guard let self = self else { return }
            
            if self.dataManager.parseMovieList(data: data) == .success {
                //print("parseMovieList: success")
            }else {
                print("parseMovieList: failed")
            }
            
            DispatchQueue.main.async {
                if let allMovies = Self.sharedCoreDataHelper.fetchMoviesFromStorage() {
                    return completionHandler(allMovies, error)
                }else {
                    return completionHandler([], error)
                }
            }
        }
    }
    
    public func downloadMovieDetails(forId: Int16, completionHandler: @escaping (MovieProtocol?, DownloadError) -> ()) {
        let uri = String(format: "%@%d.json", CONSTACTS.MOVIE_DETAILS_DATA_URI, forId)
        self.httpClient.downoadData(urlStr: uri) { [weak self] (data : Data?, error : DownloadError) in
            
            guard let self = self else { return }
            
            if self.dataManager.parseMovieDetails(data: data) == .success {
                //print("parseMovieDetails: success")
            }else {
                print("parseMovieDetails: failed")
            }
            
            DispatchQueue.main.async {
                if let aDetailedMovie = Self.sharedCoreDataHelper.fetchMovieFromStorage(id: forId) {
                    return completionHandler(aDetailedMovie, error)
                }else {
                    return completionHandler(nil, error)
                }
            }
        }
    }
    
    public func downloadRecommendedMovies(forId: Int16, completionHandler: @escaping ([MovieProtocol], DownloadError) -> ()) {
        let uri = String(format: "%@%d.json", CONSTACTS.MOVIE_RECOMMENDED_LIST_DATA_URI, forId)
        self.httpClient.downoadData(urlStr: uri) { [weak self]  (data : Data?, error : DownloadError) in
            
            guard let self = self else { return }
        
            if self.dataManager.parseMovieRecommended(data: data, movieId: forId) == .success {
                //print("parseMovieRecommended: success")
            }else {
                print("parseMovieRecommended: failed")
            }
            
            DispatchQueue.main.async {
                
                if let movie = Self.sharedCoreDataHelper.fetchMovieFromStorage(id: forId),
                   let ids = movie.recommendedIDs {
                    let myRecommendedMovies = Self.sharedCoreDataHelper.fetchMoviesFromStorage(forIds: ids)
                        return completionHandler(myRecommendedMovies, error)
                }
                
                return completionHandler([], error)
            }
        }
    }
    
    public func getFromStorageRecommendedMovies(forId: Int16) -> [MovieProtocol] {
        
        if let movie = Self.sharedCoreDataHelper.fetchMovieFromStorage(id: forId),
           let ids = movie.recommendedIDs {
            let myRecommendedMovies = Self.sharedCoreDataHelper.fetchMoviesFromStorage(forIds: ids)

            return myRecommendedMovies
        }
        
        return []
    }
 
}

