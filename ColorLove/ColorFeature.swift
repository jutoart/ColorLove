//
//  ColorFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture

@Reducer
struct ColorFeature {
  @ObservableState
  struct State: Equatable {
    var colorHexString: String
    var loveCount = 0
  }

  enum Action {
    case colorTapped
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .colorTapped:
        state.loveCount += 1
        return .none
      }
    }
  }
}
