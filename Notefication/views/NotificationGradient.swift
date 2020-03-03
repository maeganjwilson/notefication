//
//  NotificationGradient.swift
//  Notefication
//
//  Created by Maegan Wilson on 3/2/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import SwiftUI

struct NotificationGradient: View {
  var backgroundColor: Color = Color(hue: 0.0, saturation: 0.0, brightness: 0.0, opacity: 0.2)
  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [.gray, .blue]),
      startPoint: .bottomTrailing,
      endPoint: .topLeading
    )
  }
}

struct NotificationGradient_Previews: PreviewProvider {
  static var previews: some View {
    NotificationGradient()
  }
}
