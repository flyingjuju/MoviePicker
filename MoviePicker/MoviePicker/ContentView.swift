//
//  ContentView.swift
//  MoviePicker
//
//  Created by yi sun on 1/8/20.
//  Copyright © 2020 Yi Sun. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkingManager = NetworkingManager()
    var body: some View {
        VStack{
            ImageViewWidget(imageUrl: "https://image.tmdb.org/t/p/w400\(networkingManager.movie.poster_path)")
            Text(networkingManager.movie.title)
            Text(networkingManager.movie.overview)
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var data = Data()
    init(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {return}
        print("url: \(url)")
        URLSession.shared.dataTask(with: url){ (data,_,_) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

struct ImageViewWidget: View {
    @ObservedObject var imageLoader: ImageLoader
    init(imageUrl: String){
        imageLoader =  ImageLoader(imageUrl: imageUrl)
    }
    let image = UIImage(named: "rotate")
   
    var body: some View {
        Image(uiImage: (imageLoader.data.isEmpty) ? image! : UIImage(data: imageLoader.data)! )
        .resizable()
            .frame(width:400, height:400)
    }
}
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
