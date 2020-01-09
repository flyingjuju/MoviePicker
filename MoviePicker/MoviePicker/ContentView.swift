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

        VStack(spacing: 0.0){
            ImageViewWidget(imageUrl: "https://image.tmdb.org/t/p/w400\(networkingManager.movie.poster_path)")

                Button(action:{
                    self.networkingManager.reload()
                    print("button works")
                }){
                    Text("M")
                        .font(.system(size:70))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .frame(width: 120, height: 120)
                }
                .accentColor(.white)
                .background(Color.red)
                .cornerRadius(100)
                .frame(width: 120, height: 120)
                .offset(y:-75)
                .padding(.bottom, -75)
                .shadow(radius: 10)

           
            Text(networkingManager.movie.title)
                .font(.title)
                .foregroundColor(Color.blue)
                .multilineTextAlignment(.center)
                .frame(minHeight:20, maxHeight:70)
                
            Text(networkingManager.movie.overview)
                .font(.body)
                .multilineTextAlignment(.leading)
        }
        .padding(.top, 0.0)
    }
}

class ImageLoader: ObservableObject {
    @Published var data: Data?
    init(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {return}
        print("url: \(url)")
        let task = URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct ImageViewWidget: View {
    @ObservedObject var imageLoader: ImageLoader
    init(imageUrl: String){
        imageLoader =  ImageLoader(imageUrl: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: imageLoader.data != nil ? UIImage(data: imageLoader.data!)!  : UIImage())
            .resizable()
            .frame(height: 550.0)
            .padding(.top, 0.0)
            
    }
}
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
