//
//  ColorLoveApp.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture
import SwiftUI

@main
struct ColorLoveApp: App {
  static let store = Store(initialState: .init(colorHexString: "006FFF")) {
    ColorFeature()
  }

  var body: some Scene {
    WindowGroup {
      ColorView(store: Self.store)
    }
  }
}
