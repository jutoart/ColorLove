//
//  ColorFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture

struct ColorFeatureState: Equatable {
  var colorHexString: String
  var loveCount = 0
}

enum ColorFeatureAction {
  case colorTapped
}

let colorFeatureReducer = AnyReducer<ColorFeatureState, ColorFeatureAction, Void> { state, action, _ in
  switch action {
  case .colorTapped:
    state.loveCount += 1
    return .none
  }
}
