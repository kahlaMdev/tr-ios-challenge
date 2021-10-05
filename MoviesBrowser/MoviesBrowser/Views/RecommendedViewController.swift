//
//  RecommendedViewController.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import UIKit

class RecommendedViewController: UIViewController
                                 , UICollectionViewDataSource
                                 , UICollectionViewDelegate
{
    
    private enum Constants {
        static let RecommendedCellIdentifier = "recommendedCellId"
    }
    

    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    private var recommendedMovies = [MovieProtocol]()
    
    // View Model
    private var recommendedViewModel: RecommendedViewModel?
    
    public func setMovie(_ aMovie: MovieProtocol) {
        self.recommendedViewModel = RecommendedViewModel(aMovie: aMovie, labrairyAPI: LibraryAPI.shared)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.recommendedViewModel?.recommendedMovies.bind {  [weak self] (movies) in
            
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.recommendedMovies = movies
                self.recommendedCollectionView.reloadData()
            }
        }
        
        //1- get stored Recommend to load in the UI
        self.recommendedMovies = self.recommendedViewModel?.getStoredRecommended() ?? []
        
        //2- request recommend update
        self.recommendedViewModel?.getRecommended()
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  Constants.RecommendedCellIdentifier,
                                                            for: indexPath) as? RecommendedCollectionViewCell else {
            fatalError("Unable to dequeue CatalogCollectionViewCell")
        }
        
        let itemIndex = indexPath.item
        let movie = recommendedMovies[itemIndex]
        
        cell.recommendImageView.image = movie.thumbnailImage
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate

}
