//
//  ColorListFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture

@Reducer
struct ColorListFeature {
  @ObservableState
  struct State: Equatable {
    var colors: IdentifiedArrayOf<ColorModel> = []

    var path = StackState<Path.State>()
  }

  enum Action {
    case generateButtonTapped
    case path(StackActionOf<Path>)
    case newColorGenerated(hexString: String)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .generateButtonTapped:
        return .run { send in
          @Dependency(\.withRandomNumberGenerator) var withRandomNumberGenerator

          let hexNumber = withRandomNumberGenerator { generator in
            UInt64.random(in: 0...0xFFFFFF, using: &generator)
          }

          let hexString = String(hexNumber, radix: 16, uppercase: true)
          await send(.newColorGenerated(hexString: hexString))
        }

      case .path:
        return .none

      case let .newColorGenerated(hexString):
        state.path.append(.color(.init(colorHexString: hexString)))
        state.colors.insert(.init(hexString: hexString), at: .zero)
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

extension ColorListFeature {
  @Reducer(state: .equatable)
  enum Path {
    case color(ColorFeature)
  }
}
