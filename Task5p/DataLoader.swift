//
//  DataLoader.swift
//  Task5p
//
//  Created by Usama Waheed on 3/5/20.
//  Copyright © 2020 Usama Waheed. All rights reserved.
//

import Foundation

class DataLoader  {
    
//    var movies = [Movie]()
    
    
    
    func loadData() -> [Movie] {
        guard let filePath = Bundle.main.url(forResource: "movies", withExtension: "json")else {return [Movie]()}
            
        do{
            let data = try Data(contentsOf: filePath)
            let jsonDecoder = JSONDecoder();
            let jsonData = try jsonDecoder.decode([Movie].self, from: data)
            return jsonData
        }
        catch{
            print(error)
        }
        return [Movie]()
    }
    
    func sortByGenre(movies : [Movie]) -> [Movie] {
        return movies.sorted(by: {$0.genre < $1.genre})
    }
    
    func sortByYear(movies : [Movie]) -> [Movie] {
        return movies.sorted(by: {$0.year < $1.year})
    }
    
    func searchByTitle(titleText: String, movies: [Movie]) -> [Movie] {
        return movies.filter({$0.title.prefix(titleText.count) == titleText})
    }
    
    func copyFileToDocuments() -> Bool {
        let fileManager = FileManager.default
        let documentLocation = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        guard let filePath = Bundle.main.url(forResource: "movies", withExtension: "json") else {return false}
        let documentUrl = URL(fileURLWithPath: documentLocation).appendingPathComponent(filePath.lastPathComponent)
        do {
            try? fileManager.removeItem(at: documentUrl)
            try fileManager.copyItem(at: filePath, to: documentUrl)
            print("File copied")
            return true
        }
        catch {
            print(error)
            return false
        }
        
    }
}
