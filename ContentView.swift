//
//  ContentView.swift
//  WeSplit1
//
//  Created by Marko Zivanovic on 26.4.22..
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    
    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            Text("Your name is: \(name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
