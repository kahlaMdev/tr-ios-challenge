//
//  MovieDetailModelView.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation

class MovieDetailModelView {
    
    let movie: Box<MovieProtocol>
    let movieName: Box<String?> = Box(nil)
    let releaseDate: Box<String?> = Box(nil)
    let description: Box<String?> = Box(nil)
    let plot: Box<String?> = Box(nil)
    
    private let librairyAPI : APIServiceProtocol // For DI
    
    // Depency Injection: constructor/Interface Injection
    init(aMovie: MovieProtocol, librairyAPI : APIServiceProtocol) {
        self.movie = Box(aMovie)
        self.librairyAPI = librairyAPI
    }
    
    private func releaseDateFormatted(releaseDateEpochTime : Int64) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(releaseDateEpochTime))
        return "\(date.get(.day)) of \(MovieDateFormatter.shared.formatter.string(from: date)) \(date.get(.year))"
    }

    public func getMovieDetail() {
            
        librairyAPI.downloadMovieDetails(forId:self.movie.value.identifier, completionHandler: { [weak self] (movie: MovieProtocol?, error: DownloadError) in
            
            guard let self = self else { return }
            if error != .noError {
                //TODO: Handle error
            }

            if let myMovie = movie {
                
                self.movie.value = myMovie
                
                self.movieName.value = myMovie.name
                self.description.value = myMovie.descript
                self.plot.value = myMovie.plot
                
                let formattedDate = self.releaseDateFormatted(releaseDateEpochTime:myMovie.releaseDateEpochTime)
                
                self.releaseDate.value = "Release date : " + formattedDate
            }
        })
    }
}

// A singleton
public final class MovieDateFormatter {

    public static let shared = MovieDateFormatter()
    public let formatter = DateFormatter()

    private init() {
        formatter.dateFormat = "MMMM"
    }
}
      

