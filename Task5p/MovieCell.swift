//
//  MovieCell.swift
//  Task5p
//
//  Created by Usama Waheed on 3/5/20.
//  Copyright © 2020 Usama Waheed. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    func setMovieData(movie: Movie){
        titleLabel.text = movie.title
        genreLabel.text = movie.genre
        yearLabel.text = String(movie.year)
    }
}
