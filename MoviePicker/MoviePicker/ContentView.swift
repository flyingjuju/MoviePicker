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
        Text(networkingManager.movie.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
