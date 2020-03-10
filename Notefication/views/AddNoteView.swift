//
//  AddNoteView.swift
//  Notefication
//
//  Created by Maegan Wilson on 3/9/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import SwiftUI

struct AddNoteView: View {
  @Environment(\.managedObjectContext) var context
  @Environment(\.presentationMode) var presentationMode
  @State private var noteBody: String = ""
  var body: some View {
    Form{
      Section{
        TextField("Note", text: $noteBody)
      }
      Button(action: {
        self.addNoteToCoreData()
      }){
        Text("Add note")
      }
    }
  }
  
  func addNoteToCoreData(){
    let newNote = NoteEntity(context: context)
    
    // Adding attributes
    newNote.addedDate = Date()
    newNote.id = UUID()
    newNote.body = noteBody
    newNote.isArchived = false
    newNote.isNotified = false
    newNote.modifiedDate = Date()
    
    do {
      try context.save()
      self.presentationMode.wrappedValue.dismiss()
    } catch {
      print(error)
    }
  }
}

struct AddNoteView_Previews: PreviewProvider {
  static var previews: some View {
    AddNoteView()
  }
}
