//
//  NoteDetail.swift
//  Notefication
//
//  Created by Maegan Wilson on 2/27/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import SwiftUI

struct NoteDetail: View {
  var note: NoteEntity
  var body: some View {
    VStack{
      Text(note.body ?? "NO TEXT GIVEN")
      List {
        HStack{
          Text("Date Added")
          Spacer()
          Text("\(note.addedDate!.description)")
        }
      }
    }.navigationBarTitle("Note Detail")
  }
}
