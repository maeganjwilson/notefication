//
//  Card.swift
//  Notefication
//
//  Created by Maegan Wilson on 2/27/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import SwiftUI

struct Card: View {
  var cornerRadius: CGFloat = 25.0
  var startColor: Color = Color(UIColor(named:"gradientColorOne")!)
  var midColor: Color = Color(UIColor(named:"gradientColorTwo")!)
  var endColor: Color = Color(UIColor(named:"gradientColorThree")!)
  var fontColor: Color = Color(UIColor(named: "CardTextColor")!)
  var horizontalPadding: CGFloat = 10.0
  
  var note: NoteEntity
  
  @State private var isNotified: Bool = false
  
  var body: some View {
    HStack{
      Text(note.body ?? "NO TEXT GIVEN")
        .font(.subheadline)
        .multilineTextAlignment(.leading)
        .lineLimit(2)
        .padding(.leading)
      Spacer()
      VStack(alignment: .trailing){
        Text("Modded: \(note.modifiedDate!.toReadableString())")
          .font(.subheadline)
        Button(action: {
          // TODO: Add action to toggle notification correctly
          print("toggle notification")
        }){
          isNotified ? Image(systemName: "bell") : Image(systemName: "bell.slash.fill")
        }
      }
      .padding(.trailing)
    }
    .foregroundColor(fontColor)
    .frame(width: 350.0,height: 100)
    .background(
      LinearGradient(
        gradient: Gradient(colors: [startColor, midColor, endColor]),
        startPoint: .bottomTrailing,
        endPoint: .topLeading
      )
    )
      .cornerRadius(cornerRadius)
      .padding(.bottom)
      .onAppear {
        self.isNotified = self.note.isNotified
    }
  }
}

//struct Card_Previews: PreviewProvider {
//  static var previews: some View {
//    //   Card(noteText: "Here is the text for the notification\nNotification text will be here\nNotification text will be here")
//    Group{
//      Card(noteText: "Here is the text for notifications").colorScheme(.light)
//      Card(noteText: "Here is the text for notifications").colorScheme(.dark)
//    }
//  }
//}
