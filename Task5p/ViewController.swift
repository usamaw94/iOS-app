//
//  ViewController.swift
//  Task5p
//
//  Created by Usama Waheed on 2/5/20.
//  Copyright © 2020 Usama Waheed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let dataLoader = DataLoader()
    
    var movies = [Movie]()
    
    var searchedResult = [Movie]()
    
    var isSearching = false
    
    @IBOutlet weak var searchInput: UISearchBar!
    
    @IBOutlet weak var movieTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movies = dataLoader.loadData()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func sortByGenre(_ sender: Any) {
        self.movies = dataLoader.sortByGenre(movies: self.movies)
        self.movieTable.reloadData()
    }
    
    @IBAction func sortByYear(_ sender: Any) {
        self.movies = dataLoader.sortByYear(movies: self.movies)
        self.movieTable.reloadData()
    }
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.searchedResult.count
        } else {
            return self.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieData = self.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItem" ) as! MovieCell
        
        if isSearching {
            cell.setMovieData(movie: self.searchedResult[indexPath.row])
        } else {
            cell.setMovieData(movie: movieData)
        }
        
        return cell
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedResult = dataLoader.searchByTitle(titleText: searchText, movies: self.movies)
        
        isSearching = true
        
        self.movieTable.reloadData()
    }
}

