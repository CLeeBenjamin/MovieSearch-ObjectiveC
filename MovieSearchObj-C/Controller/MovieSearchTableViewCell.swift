//
//  MovieSearchTableViewCell.swift
//  MovieSearchObj-C
//
//  Created by Caston  Boyd on 6/6/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    
    //MARK: - Properties
    var movies: Movie? {
        didSet {
            updateViews()
        }
    }
    
    var thumbNail: UIImage? {
        didSet{
            updateViews()
        }
        
    }
    
    //MARK: - Method
    func updateViews() {
        guard let movie = movies else { return  }
        if thumbNail != nil{
            movieImageView.image = thumbNail
            
        }
        //MARK: - Update Texts
        movieTitle.text =  (String(describing: movie.title))
        self.movieRating.text = "Rating: \(String(describing: movie.ratings))"
        self.movieOverview.text = "Overview: \(String(describing: movie.overview))"
        //MARK: - Update Image
        MovieController.sharedInstance().fetchImages(with: movie.image) { (newImage) in
            DispatchQueue.main.async {
                self.movieImageView.image = newImage
            }
        }
    }
}


