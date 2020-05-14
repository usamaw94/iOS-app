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
    var updateAtIndex = -1
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "addMovie"){
            let addVC = segue.destination as! AddMovieViewController
            addVC.dataLoader = self.dataLoader
            addVC.homeVC = self
        }
        else{
            let editVC = segue.destination as! EditMovieViewController
            editVC.currentIndex = self.updateAtIndex
            editVC.dataLoader = self.dataLoader
            editVC.homeVC = self
        }
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editFunction = UITableViewRowAction(style: .normal, title: "Update") { (rowAction, indexpath) in
            self.updateAtIndex = indexPath.row
            self.performSegue(withIdentifier: "UpdateMovieItem", sender: self)
        }
        editFunction.backgroundColor = UIColor.blue
        
        
        let deleteFunction = UITableViewRowAction(style: .normal, title: "Remove") { (rowAction, indexpath) in
            
            self.movies = self.dataLoader.deleteMovieItem(itemIndex: indexPath.row, isSearching: self.isSearching, movies: self.movies, searchedResult: self.searchedResult)
            self.movieTable.deleteRows(at: [indexPath], with: .fade)
            self.movieTable.reloadData()
        }
        deleteFunction.backgroundColor = UIColor.red
        
        return [deleteFunction,editFunction]
    }
}

extension ViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedResult = dataLoader.searchByTitle(titleText: searchText, movies: self.movies)
        
        isSearching = true
        
        self.movieTable.reloadData()
    }
}

