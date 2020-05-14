//
//  DataLoader.swift
//  Task5p
//
//  Created by Usama Waheed on 3/5/20.
//  Copyright © 2020 Usama Waheed. All rights reserved.
//

import Foundation

class DataLoader  {
    
    var fileLocation : URL?
    
//    var movies = [Movie]()
    
    
    
    func loadData() -> [Movie] {
        let fileManager = FileManager.default
        
        fileLocation = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("movies.json")
        
        if(fileManager.fileExists(atPath: self.fileLocation?.path ?? "")){
            do{
                let data = try Data(contentsOf: self.fileLocation ?? fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0])
                let jsonDecoder = JSONDecoder();
                let jsonData = try jsonDecoder.decode([Movie].self, from: data)
                return jsonData
            }
            catch{
                print(error)
            }
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
    
    func writeDataToFile(fileData: String){
        let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("movies.json")
        print(fileUrl)
        do {
            try fileData.write(to: fileUrl, atomically: true, encoding: .utf8)
        }
        catch{
            print(error)
        }
    }
    
    func jsonToString(movies : [Movie]){
        let moviesList = movies
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
           let data = try encoder.encode(moviesList)
            let jsonData = String(bytes: data, encoding: .utf8)
            self.writeDataToFile(fileData: jsonData ?? "")
        }
        catch {
            print(error)
        }
    }
    
    func deleteMovieItem(itemIndex : Int, isSearching : Bool, movies : [Movie], searchedResult: [Movie]) -> [Movie]{
        var movieList = movies
        if(isSearching){
            for i in 0...movieList.count - 1 {
                if(searchedResult[itemIndex].title == movieList[i].title){
                    movieList.remove(at: i)
                    jsonToString(movies: movieList)
                    return movieList
                }
            }
        }
        else{
            movieList.remove(at: itemIndex)
            jsonToString(movies: movieList)
            return movieList
        }
        return movieList
    }
    
    func editMovieItem(itemIndex : Int, isSearching : Bool, movies : [Movie], movie : Movie, searchedResult : [Movie]) -> [Movie] {
        var movieList = movies
        if(isSearching){
            for i in 0...movieList.count - 1 {
                if(searchedResult[itemIndex].title == movieList[i].title) {
                    movieList[i] = movie
                    jsonToString(movies: movieList)
                    return movieList
                }
            }
        }
        else{
            movieList[itemIndex] = movie
            jsonToString(movies: movieList)
            return movieList
        }
        return movieList
    }
    
    
}
