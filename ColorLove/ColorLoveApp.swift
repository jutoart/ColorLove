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
  var body: some Scene {
    WindowGroup {
      ColorListView(
        store: .init(
          initialState: .init(),
          reducer: colorListFeatureReducer,
          environment: .live
        )
      )
    }
  }
}
