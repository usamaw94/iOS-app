//
//  EditMovieViewController.swift
//  Task5p
//
//  Created by Usama Waheed on 12/5/20.
//  Copyright © 2020 Usama Waheed. All rights reserved.
//

import UIKit

class EditMovieViewController: UIViewController {

    @IBOutlet weak var inputMovieTitle: UITextField!
    
    @IBOutlet weak var inputGenre: UITextField!
    
    @IBOutlet weak var inputYear: UITextField!
    
    var homeVC = ViewController()
    
    var dataLoader = DataLoader()
    
    var currentIndex = -1
    
    let uniqueAlert  = UIAlertController(title: "Alert!", message: "Movie title must be unique", preferredStyle: .alert)
    
    let requiredFieldAlert = UIAlertController(title: "Alert!", message: "All input fields are required", preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(homeVC.isSearching){
            inputMovieTitle.text = homeVC.searchedResult[currentIndex].title
            inputGenre.text = homeVC.searchedResult[currentIndex].genre
            inputYear.text = String(homeVC.searchedResult[currentIndex].year)
        }
        else{
            inputMovieTitle.text = homeVC.movies[currentIndex].title
            inputGenre.text = homeVC.movies[currentIndex].genre
            inputYear.text = String(homeVC.movies[currentIndex].year)
        }
        
        uniqueAlert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("nothing")
            }
        }))
        // Do any additional setup after loading the view.
        
        requiredFieldAlert.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("nothing")
            }
        }))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateItem(_ sender: Any) {
        if(validateUniqueField()){
            if(validateRequired()){
                let movie = Movie(title: inputMovieTitle.text ?? "", genre: inputGenre.text ?? "", year: Int(inputYear.text ?? "0") ?? 0)
                
                
                homeVC.movies = dataLoader.editMovieItem(itemIndex: currentIndex, isSearching: homeVC.isSearching, movies: homeVC.movies, movie: movie, searchedResult: homeVC.searchedResult)
                homeVC.movieTable.reloadData()
                dismiss(animated: true, completion: nil)
            }
            self.present(requiredFieldAlert,animated: true, completion: nil)
        }
        self.present(uniqueAlert,animated: true, completion: nil)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func validateUniqueField() -> Bool {
        for index in 0...homeVC.movies.count - 1 {
            if(index == currentIndex){
                continue
            }
            else if(homeVC.movies[index].title == inputMovieTitle.text ?? ""){
                return false
            }
        }
        
        return true
    }
    
    func validateRequired() -> Bool {
        if(inputMovieTitle.text != nil && inputMovieTitle.text != ""){
            if(inputGenre.text != nil && inputGenre.text != "" ){
                if(inputYear.text != nil && inputYear.text != ""){
                    return true
                }
            }
        }
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
