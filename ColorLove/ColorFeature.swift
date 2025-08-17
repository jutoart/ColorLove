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
    case generateButtonTapped
    case newColorGenerated(hexString: String)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .colorTapped:
        state.loveCount += 1
        return .none

      case .generateButtonTapped:
        return .run { send in
          @Dependency(\.withRandomNumberGenerator) var withRandomNumberGenerator

          let hexNumber = withRandomNumberGenerator { generator in
            UInt64.random(in: 0...0xFFFFFF, using: &generator)
          }

          let hexString = String(hexNumber, radix: 16, uppercase: true)
          await send(.newColorGenerated(hexString: hexString))
        }

      case let .newColorGenerated(hexString):
        state.colorHexString = hexString
        state.loveCount = 0
        return .none
      }
    }
  }
}
