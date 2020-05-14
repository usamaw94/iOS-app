//
//  AddMovieViewController.swift
//  Task5p
//
//  Created by Usama Waheed on 12/5/20.
//  Copyright © 2020 Usama Waheed. All rights reserved.
//

import UIKit

class AddMovieViewController: UIViewController {
    
    @IBOutlet weak var inputMovieTitle: UITextField!
    
    @IBOutlet weak var inputGenre: UITextField!
    
    @IBOutlet weak var inputYear: UITextField!
    
    var homeVC = ViewController()
    
    var dataLoader = DataLoader()
    
    
    
    let uniqueAlert  = UIAlertController(title: "Alert!", message: "Movie title must be unique", preferredStyle: .alert)
    
    let requiredFieldAlert = UIAlertController(title: "Alert!", message: "All input fields are required", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    
    @IBAction func addMovieToList(_ sender: Any) {
        if(validateUniqueField()){
            if(validateRequired()){
                let movie = Movie(title: inputMovieTitle.text ?? "", genre: inputGenre.text ?? "", year: Int(inputYear.text ?? "0") ?? 0)
                homeVC.movies.append(movie)
                dataLoader.jsonToString(movies: homeVC.movies)
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
        
        if(homeVC.movies.count == 0){
            return true
        }
        
        for index in 0...homeVC.movies.count - 1 {
            if(homeVC.movies[index].title == inputMovieTitle.text ?? ""){
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
    
}
