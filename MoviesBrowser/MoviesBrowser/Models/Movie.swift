//
//  Movie.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-02.
//

import Foundation
import UIKit
import CoreData

// A singleton
public final class MovieDateFormatter {

    public static let shared = MovieDateFormatter()
    public let formatter = DateFormatter()

    private init() {
        formatter.dateFormat = "MMMM"
    }
}

/**
 Movie: is an NSManagedObject class as a Data Model Entity for Core Data
 */
@objc(Movie)
public class Movie: NSManagedObject
{

    public static let entityName = "Movie"
    
    // MARK: - Core Data Managed Object
    
    @NSManaged public var identifier: Int16
    
    @NSManaged public var name: String
    @NSManaged public var descript: String
    @NSManaged public var plot: String
    @NSManaged public var releaseDateEpochTime: Int64
    @NSManaged public var rating: Float
    @NSManaged public var year: Int16
    
    @NSManaged public var picture: String? // URL String of picture image
    @NSManaged public var thumbnail: String? // URL String of thumbnail image
    
    // The list of recommended Movies for this movie as an Ordred Set!
    @NSManaged public var recommendedMovies: NSOrderedSet
    
    @NSManaged public var pictureData: Data?
    @NSManaged public var thumbnailData: Data?
    
    // Not saved in coreData!
    public var pictureImage:UIImage? {
        get {
            if let myPictureData = self.pictureData {
                return UIImage(data: myPictureData)
            }else if let pictureURL = picture {
                let tuple = UIImage.downloadImage(pictureURL)
                self.pictureData = tuple.data
                return tuple.image
            }
            return nil
        }
    }
    
    public var thumbnailImage:UIImage? {
        get {
            if let myThumbnailData = self.thumbnailData {
                return UIImage(data: myThumbnailData)
            }else if let thumbnailURL = thumbnail {
                let tuple = UIImage.downloadImage(thumbnailURL)
                self.thumbnailData = tuple.data
                return tuple.image
            }
            return nil
        }
    }
    
    var releaseDateFormatted: String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(releaseDateEpochTime))
        return "\(date.get(.day)) of \(MovieDateFormatter.shared.formatter.string(from: date)) \(date.get(.year))"
    }
    
    // MARK: - Setup non saved value in Code Data
//    private func setupMovie() {
//
//    }
//
//    public override func awakeFromFetch() {
//        super.awakeFromFetch()
//        setupMovie()
//    }
//
//    public override func awakeFromInsert() {
//        super.awakeFromInsert()
//        setupMovie()
//    }
//
//    public override func didTurnIntoFault() {
//        super.didTurnIntoFault()
//        setupMovie()
//    }
    
    // MARK: - description
    public override var description: String {
        
        var desc = "\n\n\n Movie: "
        desc += "identifier: \(self.identifier) \n"
        desc += "\t name: \(name) \n"
        desc += "\t releaseDate: \(releaseDateEpochTime) \n"
        desc += "\t descript: \(descript) \n"
        desc += "\t plot: \(plot) \n"
        desc += "\t rating: \(rating) \n"
        desc += "\t year: \(year) \n"
        desc += "\t picture: \(String(describing: picture)) \n"
        desc += "\t thumbnail: \(String(describing: thumbnail)) \n\n"
        
        var moviesIds = [Int16]()
        let myRecommanded = self.recommendedMovies
        for movie in myRecommanded {
            if let myMovie = movie as? Movie {
                moviesIds.append(myMovie.identifier)
            }
        }
        
        desc += "recommended Movies ids: \(moviesIds)) \n"
        
        return desc
    }
}

// Persistently unique per environment (e.g. database record keys).
// from : https://developer.apple.com/documentation/swift/identifiable
extension Movie : Identifiable {

}

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: Movie.entityName)
    }
}

// MARK: Generated accessors for recommendedMovies
extension Movie {

    @objc(insertObject:inRecommendedMoviesAtIndex:)
    @NSManaged public func insertIntoRecommendedMovies(_ value: Movie, at idx: Int)

    @objc(removeObjectFromRecommendedMoviesAtIndex:)
    @NSManaged public func removeFromRecommendedMovies(at idx: Int)

    @objc(insertRecommendedMovies:atIndexes:)
    @NSManaged public func insertIntoRecommendedMovies(_ values: [Movie], at indexes: NSIndexSet)

    @objc(removeRecommendedMoviesAtIndexes:)
    @NSManaged public func removeFromRecommendedMovies(at indexes: NSIndexSet)

    @objc(replaceObjectInRecommendedMoviesAtIndex:withObject:)
    @NSManaged public func replaceRecommendedMovies(at idx: Int, with value: Movie)

    //
    @objc(replaceRecommendedMoviesAtIndexes:withRecommendedMovies:)
    @NSManaged public func replaceRecommendedMovies(at indexes: NSIndexSet, with values: [Movie])

    @objc(addRecommendedMoviesObject:)
    @NSManaged public func addToRecommendedMovies(_ value: Movie)

    @objc(removeRecommendedMoviesObject:)
    @NSManaged public func removeFromRecommendedMovies(_ value: Movie)

    @objc(addRecommendedMovies:)
    @NSManaged public func addToRecommendedMovies(_ values: NSOrderedSet)

    @objc(removeRecommendedMovies:)
    @NSManaged public func removeFromRecommendedMovies(_ values: NSOrderedSet)

}

