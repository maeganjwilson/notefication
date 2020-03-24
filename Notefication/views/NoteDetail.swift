//
//  NoteDetail.swift
//  Notefication
//
//  Created by Maegan Wilson on 2/27/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import SwiftUI
import CoreData

struct NoteDetail: View {
  @Environment(\.managedObjectContext) var context
  @State private var isNotified: Bool = false
  @State private var isArchived: Bool = false
  var note: NoteEntity
  var body: some View {
    VStack(alignment: .leading){
      HStack{
        Text(note.body ?? "NO TEXT GIVEN")
          .padding(.leading)
      }
      Form {
        // MARK: Toggle
        Toggle(isOn: Binding(
          get: {
            self.isNotified
        }, set: {(newValue) in
          self.isNotified = newValue
          self.updateIsNotified()
        })) {
          Text("Notify?")
        }
        Section{
          HStack{
            Text("Date Last Modified")
            Spacer()
            Text("\(note.modifiedDate!.toReadableString())")
          }
          HStack{
            Text("Date Added")
            Spacer()
            Text("\(note.addedDate!.toReadableString())")
          }
        }
        // MARK: Button
        Button(action: {
          self.archiveNote()
        }){
          Text("Archive")
            .foregroundColor(isArchived ? Color.green : Color.red)
        }
      }
    }.listStyle(GroupedListStyle())
    .navigationBarTitle("Note Detail")
      .onAppear {
        self.isArchived = self.note.isArchived
        self.isNotified = self.note.isNotified
    }
  }
  
  func updateIsNotified(){
    let noteID: NSUUID = note.id! as NSUUID
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "NoteEntity")
    fetchRequest.predicate = NSPredicate(format: "id == %@", noteID as CVarArg)
    fetchRequest.fetchLimit = 1
    do {
      let test = try context.fetch(fetchRequest)
      let noteUpdate = test[0] as! NSManagedObject
      noteUpdate.setValue(isNotified, forKey: "isNotified")
      noteUpdate.setValue(Date(), forKey: "modifiedDate")
      try context.save()
    } catch {
      print(error)
    }
  }
  
  func archiveNote() {
    isArchived.toggle()
    let noteID: NSUUID = note.id! as NSUUID
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "NoteEntity")
    fetchRequest.predicate = NSPredicate(format: "id == %@", noteID as CVarArg)
    fetchRequest.fetchLimit = 1
    do {
      let test = try context.fetch(fetchRequest)
      let noteUpdate = test[0] as! NSManagedObject
      noteUpdate.setValue(isArchived, forKey: "isArchived")
      noteUpdate.setValue(Date(), forKey: "modifiedDate")
      try context.save()
    } catch {
      print(error)
    }
  }
}
