//
//  ContentView.swift
//  Notefication
//
//  Created by Maegan Wilson on 2/27/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  init() {
    UITableView.appearance().separatorStyle = .none
  }
  
  var body: some View {
    NavigationView{
      ScrollView(){
        ForEach(0 ..< 10) { item in
          NavigationLink(destination: NoteDetail()) {
            Card(noteText: "Notification text will be here here is more notification text.. ")
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
