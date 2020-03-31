//
//  NotificationCenterKey.swift
//  Notefication
//
//  Created by Maegan Wilson on 3/30/20.
//  Copyright © 2020 Maegan Wilson. All rights reserved.
//

import Foundation
import SwiftUI
import UserNotifications

struct NotCentKey: EnvironmentKey {
  static var defaultValue: UNUserNotificationCenter = UNUserNotificationCenter.current()
}

extension EnvironmentValues {
  var notCentKey: UNUserNotificationCenter {
    get { self[NotCentKey.self] }
    set { self[NotCentKey.self] = newValue }
  }
}
