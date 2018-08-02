//
//  MovieTableViewController.swift
//  MovieSearchObj-C
//
//  Created by Caston  Boyd on 6/6/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Outlets
    @IBOutlet var movieSearchTableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self
        movieSearchTableView.delegate = self
        movieSearchTableView.rowHeight = 280
        self.tableView.separatorColor = UIColor.black
    }
    
    //MARK: - Movie PlaceHolder
    var movies: [Movie] = []{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: - FetchMovie Method from MovieController
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let searchedItem = movieSearchBar.text else { return }
        
        MovieController.sharedInstance().fetchMovies(with: searchedItem) { (movies, error) in
            self.movies = movies
        DispatchQueue.main.async {
            self.movieSearchBar.text = ""
            }
        }
    
  movieSearchBar.resignFirstResponder()
        
}
    
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return movies.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.movies = movie
        
    
        
        

        return cell
    }
 
 
}//end of class
