//
//  MovieDetailViewController.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieDetailScrolView: UIScrollView!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var imageViewHeigthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    // Recommended Container View
    @IBOutlet weak var recommendedViewContainer: UIView!
    @IBOutlet weak var recommendedViewHeigthConstraint: NSLayoutConstraint!
    
    // View Model
    private var moviesDetailViewModel:MovieDetailModelView?
    
    public func setMovie(_ aMovie: Movie) {
        self.moviesDetailViewModel = MovieDetailModelView(aMovie: aMovie)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.moviesDetailViewModel?.movie.bind {  [weak self] (updatedMovie) in
            
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateUIOnMainThread(forMovie: updatedMovie)
            }
        }
        
        self.moviesDetailViewModel?.getMovieDetail()
    }
    
    private func updateUIOnMainThread(forMovie: Movie){
        self.title = forMovie.name
        self.setImage(forMovie.pictureImage)
        movieName.text = forMovie.name
        releaseDateLabel.text = "Release date : " + forMovie.releaseDateFormatted
        
        descriptionLabel.text = forMovie.descript
        plotLabel.text = forMovie.plot
        
        self.movieDetailScrolView.scrollToTop(animated: true)
        
    }
    
    private func setImage(_ image: UIImage?) {
        
        pictureImageView.image = image
        
        if let myImage = image {
            let size = myImage.size
            let imageViewWidth = pictureImageView.frame.size.width
            imageViewHeigthConstraint.constant = size.height / size.width * imageViewWidth
            view.layoutIfNeeded()
            
        }else {
            imageViewHeigthConstraint.constant = 0.0
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination
        if(segue.identifier == "ContainerRecommended") {
            if let recommendedVC = destination as? RecommendedViewController {
                guard let myMovie = self.moviesDetailViewModel?.movie.value else { return }
                recommendedVC.setMovie(myMovie)
            }
        }
    }
    

}
