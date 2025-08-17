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
  static let store = Store(initialState: .init()) {
    ColorListFeature()
  }

  var body: some Scene {
    WindowGroup {
      ColorListView(store: Self.store)
    }
  }
}
