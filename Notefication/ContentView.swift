//
//  ContentView.swift
//  Notefication
//
//  Created by Maegan Wilson on 2/27/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var context
  
  @FetchRequest(
    entity: NoteEntity.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \NoteEntity.modifiedDate, ascending: false)]
  ) var notes: FetchedResults<NoteEntity>
  
  @State private var isNoteBeingAdded: Bool = false
  
  var body: some View {
    VStack {
      Button(action: {
        self.isNoteBeingAdded = true
      }) {
        Text("Add Note")
      }.sheet(isPresented: $isNoteBeingAdded) {
        AddNoteView().environment(\.managedObjectContext, self.context)
      }
      NavigationView{
        ScrollView(){
          ForEach(notes, id: \.id) { item in
            NavigationLink(destination: NoteDetail(note: item)) {
              Card(note: item)
            }
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
