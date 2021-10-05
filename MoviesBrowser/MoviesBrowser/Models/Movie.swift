//
//  Movie.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-02.
//

import Foundation
import UIKit
import CoreData

/**
 Movie: is an NSManagedObject class as a Data Model Entity for Core Data
 */
@objc(Movie)
public class Movie: NSManagedObject, MovieProtocol
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
    
    // The list of recommended Movies Ids!
    @NSManaged public var recommendedIDs: Array<Int16>?
    
    @NSManaged public var pictureData: Data?
    @NSManaged public var thumbnailData: Data?
    
    // Not saved in coreData!
    public var pictureImage:UIImage? {
        get {
            // Image Data is saved for Caching...
            // Caching Movie Image as it is very unlikly to get changed
            // Movie images don't change after movie release
            // ...
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
            // Image Data is saved for Caching...
            // Caching Movie Image as it is very unlikly to get changed
            // Movie images don't change after movie release
            // ...
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
        desc += "recommendedIDs: \(String(describing: recommendedIDs)) \n" //
        
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


