//
//  DataSourceManager.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation
import UIKit

enum DataProcessingState {
    case fail
    case success
}

// A Singleton class to manage data
final class DataSourceManager {
    
    func parseMovieList(data: Data?) -> DataProcessingState {
        
        if let jsonData = data {
            do {
                let decoder = JSONDecoder()
                let moviesList = try decoder.decode(MoviesList.self, from: jsonData)
                
                CoreDataMoviesHelper.shared.updateDataBaseWithMoviesList(movies: moviesList)
                
                return .success
                
            } catch let error {
                print(error)
                return .fail
            }
        }
        
        return .fail
    }
    
    func parseMovieDetails(data: Data?) -> DataProcessingState {
        
        if let jsonData = data {
            do {
                let decoder = JSONDecoder()
                let movieDetail = try decoder.decode(MovieDetail.self, from: jsonData)
                
                CoreDataMoviesHelper.shared.updateDataBaseWithMovieDetail(movieDetail: movieDetail)
                
                return .success
                
            } catch let error {
                print(error)
                return .fail
            }
        }
        
        return .fail
    }
    
    func parseMovieRecommended(data: Data?, movieId: Int16) -> DataProcessingState {
        
        if let jsonData = data {
            do {
                let decoder = JSONDecoder()
                let recommendedMovies = try decoder.decode(MoviesList.self, from: jsonData)
                
                CoreDataMoviesHelper.shared.updateMovie(id: movieId, recommendedMovies: recommendedMovies)
                
                return .success
                
            } catch let error {
                print(error)
                return .fail
            }
        }
        
        return .fail
    }
        
}