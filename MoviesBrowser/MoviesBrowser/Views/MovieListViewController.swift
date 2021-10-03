//
//  MovieListViewController.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import UIKit

class MovieListViewController: UIViewController,
                               UITableViewDataSource, UITableViewDelegate {
    
    private enum Constants {
        static let MovieListCellIdentifier = "movieListCellId"
    }

    @IBOutlet weak var moviesTableView: UITableView!
    
    private var movies = [Movie]()
    
    // View Model
    private let moviesListViewModel = MovieListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Movies"
        
        moviesTableView.estimatedRowHeight = 120.0
        moviesTableView.rowHeight = UITableView.automaticDimension
        
        self.moviesListViewModel.movies.bind { [weak self] (movies : [Movie]) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movies = movies
                self.moviesTableView.reloadData()
            }
        }
        
        self.moviesListViewModel.getMoviesList()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination
        if(segue.identifier == "MovieDetail") {
            if let movieDetailVC = destination as? MovieDetailViewController {
                if let mySelectedCell = sender as? UITableViewCell {
                    if let selectedIndex = moviesTableView.indexPath(for: mySelectedCell) {
                        
                        moviesTableView.deselectRow(at: selectedIndex, animated: true)
                        
                        let index = selectedIndex.row
                        let movie = movies[index]
                        movieDetailVC.setMovie(movie)
                    }
                }
            }
        }
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MovieListCellIdentifier) as? MovieListTableViewCell else {
            fatalError("Unable to dequeue CatalogCollectionViewCell")
        }
        
        let index = indexPath.row
        let movie = movies[index]
        
        cell.thumbnailImageView.image = movie.thumbnailImage
        cell.nameLabel.text = movie.name
        cell.yearLabel.text = "\(movie.year)"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let index = indexPath.row
//        let movie = movies[index]
//
//        //MovieDetailViewController
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
}

