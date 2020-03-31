//
//  NoteDetail.swift
//  Notefication
//
//  Created by Maegan Wilson on 2/27/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import SwiftUI
import CoreData
import UserNotifications

struct NoteDetail: View {
  @Environment(\.managedObjectContext) var context
  @Environment(\.notCentKey) var center
  
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
          self.updateScheduledNotification()
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
  
  func updateScheduledNotification(){
    print("Called")
    center.getNotificationSettings { (settings) in
      if settings.authorizationStatus != .authorized {
        print("Not authorized")
        // TODO: Implement an alert to signal that it's not authorized
      }
    }
    makeNotification()
  }
  
  // MARK: MAKE NOTIFICATION
  func makeNotification(){
    print("Called")
    let content = UNMutableNotificationContent()
    content.title = note.body ?? "NO TEXT FOUND"
    content.body = note.body ?? "NO TEXT FOUND"
    
    // MARK: SCHEDULE DELIVERY
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    
    dateComponents.weekday = 2
    dateComponents.hour = 19
    dateComponents.minute = 34
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    let uuidString = UUID().uuidString
    let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
    
    center.add(request) { (error) in
      if error != nil {
        print(error)
      }
    }
  }
}
