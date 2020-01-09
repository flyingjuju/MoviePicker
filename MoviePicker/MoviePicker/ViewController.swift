//
//  ViewController.swift
//  MoviePicker
//
//  Created by yi sun on 1/8/20.
//  Copyright © 2020 Yi Sun. All rights reserved.
//

import Foundation

struct MovieEntry: Decodable {
    var title: String
    var overview: String
    var poster_path: String
    var id: Int
}

class NetworkingManager: ObservableObject {
    var movieId = Int.random(in: 100..<400000)
    @Published var movie = MovieEntry(title:"",overview: "",poster_path:"",id:301528)
    
    
    
    func load(){
       movieId = Int.random(in: 100..<400000)
       print(">>>>>>>>>\(movieId)")
       guard let url = URL(string: "http://api.themoviedb.org/3/movie/\(movieId)?api_key=3d93489c75b4c4f48c56e9e57ccbd986") else {return}
        
       let dataTask = URLSession.shared.dataTask(with: url){ (newData,response,error) in
           guard let newData = newData else {return}
//            print("JSON String: \(String(describing: String(data: data, encoding: .utf8)))"
           if error == nil  {
               do {
                   let movie = try JSONDecoder().decode(MovieEntry.self, from: newData)
                       DispatchQueue.main.async {
                          self.movie = movie
                      }
               } catch {
                   DispatchQueue.main.async {
                    self.movie = MovieEntry(title:"Toy Story 4",overview: "Woody has always been confident about his place in the world and that his priority is taking care of his kid, whether that's Andy or Bonnie. But when Bonnie adds a reluctant new toy called \"Forky\" to her room, a road trip adventure alongside old and new friends will show Woody how big the world can be for a toy.",poster_path:"/w9kR8qbmQ01HwnvK4alvnQ2ca0L.jpg",id:301528)
                    self.movie.id =  self.movieId
                       print("hererere cant get \(self.movie) .....")
                   }
               }
           }
        }
        dataTask.resume()
    }
}

    
