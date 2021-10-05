//
//  CoreDataMoviesHelper.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-01.
//

import Foundation
import CoreData

// Singleton
final class CoreDataMoviesHelper: CoreDataMovieServiceProtocol {
   
    static let shared = CoreDataMoviesHelper()
    private init() {
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MoviesBrowser")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        // Configure
        //container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy =
            NSMergePolicy(merge:
                            //.mergeByPropertyStoreTrumpMergePolicyType
                            .mergeByPropertyObjectTrumpMergePolicyType
                            //.overwriteMergePolicyType
            )
        
        return container
    }()
    
    /**
     A reference to the NSManagedObjectContext that is created and owned by the persistent container which is associated with the main queue of the application. This context is created automatically as part of the initialization of the persistent container.
     */
    /// This function returns `viewContext`.
    ///
    /// - Warning: The context shoud be used on the main queue of the application.
    /// - Returns: NSManagedObjectContext
    public func getViewContext() ->  NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        DispatchQueue.main.async {
            let context = self.getViewContext()
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
    
    public func getMoviesCount() -> Int{
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Movie.entityName)
            request.includesSubentities = false
            
            let count = try persistentContainer.viewContext.count(for: request)
            return count
        } catch let error {
            print(error)
            return 0
        }
    }
    
    public func fetchMoviesFromStorage() -> [MovieProtocol]? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Movie>(entityName: Movie.entityName)
        let sortDescriptor1 = NSSortDescriptor(key: "identifier", ascending: true)
        //let sortDescriptor2 = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1] //, sortDescriptor2]
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users
        } catch let error {
            print(error)
            return nil
        }
    }
    
    public func fetchMovieFromStorage(id: Int16) -> MovieProtocol? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Movie>(entityName: Movie.entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@",
                                                 argumentArray: [id])
        
        do {
            let movies = try managedObjectContext.fetch(fetchRequest)
            return movies.first
        } catch let error {
            print(error)
            return nil
        }
    }
    
    public func fetchMoviesFromStorage(forIds: [Int16]) -> [MovieProtocol] {
        
        var movies = [Movie]()
        for movieId in forIds {
            
            if let recommendedMovie = CoreDataMoviesHelper.shared.fetchMovieFromStorage(id: movieId) {
                movies.append(recommendedMovie as! Movie)
            }
        }
        
        return movies
    }
    
    public func deleteAllMovies() {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: Movie.entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedObjectContext.execute(deleteRequest)
            self.saveContext()
        } catch let error as NSError {
            //Handle the error
            print(error)
        }
    }
    
    public func updateDataBaseWithMoviesList(movies: MoviesList){
        for movie in movies.movies {
            self.updateDataBaseWithMovieModel(movie: movie)
        }
    }
    
    public func updateDataBaseWithMovieModel(movie: MovieModel) {
        
        // Very Important to be SYNC as we want to be sure the CoreData has been update "before" returning Success!
        DispatchQueue.main.sync {
            let identifier = movie.identifier
            
            if let myMovie = self.fetchMovieFromStorage(id: identifier) {
                // update
                self.updateMovie(movie: myMovie as! Movie, fromMovieModel: movie)
                
            }else {
                //Insert + update
                if let myMovie = NSEntityDescription.insertNewObject(forEntityName: Movie.entityName, into: self.getViewContext()) as? Movie {
                    
                    myMovie.identifier = identifier
                    self.updateMovie(movie: myMovie, fromMovieModel: movie)
                }
            }
            
            self.saveContext()
        }
    }
    
    public func updateDataBaseWithMovieDetail(movieDetail: MovieDetail) {
        
        // Very Important to be SYNC as we want to be sure the CoreData has been update "before" returning Success!
        DispatchQueue.main.sync {
            let identifier = movieDetail.identifier
            
            if let myMovie = self.fetchMovieFromStorage(id: identifier) {
                // update
                self.updateMovie(movie: myMovie as! Movie, fromMovieDetail: movieDetail)
                
            }else {
                //Insert + update
                if let myMovie = NSEntityDescription.insertNewObject(forEntityName: Movie.entityName, into: self.getViewContext()) as? Movie {
                    
                    myMovie.identifier = identifier
                    self.updateMovie(movie: myMovie, fromMovieDetail: movieDetail)
                }
            }
            
            self.saveContext()
        }
    }
    
    public func updateMovie(id: Int16, recommendedMovies:MoviesList) {
        
        // Very Important to be SYNC as we want to be sure the CoreData has been update "before" returning Success!
        DispatchQueue.main.sync {
            if let movie = CoreDataMoviesHelper.shared.fetchMovieFromStorage(id: id) as? Movie {
                //1- remove (empty) any previous recommanded Movies
                movie.recommendedIDs?.removeAll()
//               // 2- add received recommanded movies
                var moviesIds = [Int16]()
                for movieModel in recommendedMovies.movies {
                    
                    moviesIds.append(movieModel.identifier)
                }
                
                movie.recommendedIDs = moviesIds
                
                self.saveContext()
            }
        }
    }
    
    private func updateMovie(movie:Movie, fromMovieModel: MovieModel) {
        movie.name = fromMovieModel.name
        movie.thumbnail = fromMovieModel.thumbnail
        movie.year = fromMovieModel.year
    }
    
    private func updateMovie(movie:Movie, fromMovieDetail: MovieDetail) {
        movie.name = fromMovieDetail.name
        movie.descript = fromMovieDetail.descript
        movie.plot = fromMovieDetail.plot
        movie.releaseDateEpochTime = fromMovieDetail.releaseDateEpochTime
        movie.picture = fromMovieDetail.picture
        movie.rating = fromMovieDetail.rating
    }
    
}
