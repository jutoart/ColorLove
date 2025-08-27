//
//  ColorListFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/18.
//

import ComposableArchitecture

struct ColorListFeatureState: Equatable {
  var colors: IdentifiedArrayOf<ColorModel> = []

  var color: ColorFeatureState?
}

enum ColorListFeatureAction {
  case color(ColorFeatureAction)
  case colorTapped(hexString: String)
  case dismissColor
  case generateButtonTapped
  case newColorGenerated(hexString: String)
}

struct ColorListFeatureEnvironment {
  var generateNewColor: () -> EffectTask<String>

  static let live = Self(
    generateNewColor: {
      let hexNumber = UInt64.random(in: 0...0xFFFFFF)
      let hexString = String(hexNumber, radix: 16, uppercase: true)
      return .init(value: hexString)
    }
  )
}

let colorListFeatureReducer = colorFeatureReducer
  .optional()
  .pullback(state: \.color, action: /ColorListFeatureAction.color, environment: { _ in })
  .combined(
    with: AnyReducer<
      ColorListFeatureState,
      ColorListFeatureAction,
      ColorListFeatureEnvironment
    > { state, action, environment in
      switch action {
      case let .color(.delegate(delegateAction)):
        switch delegateAction {
        case let .updateColor(color):
          state.colors[id: color.id] = color
          return .none
        }

      case .color:
        return .none

      case let .colorTapped(hexString):
        guard let color = state.colors[id: hexString] else {
          return .none
        }

        state.color = .init(color: color)
        return .none

      case .dismissColor:
        state.color = nil
        return .none

      case .generateButtonTapped:
        return environment.generateNewColor()
          .map(ColorListFeatureAction.newColorGenerated)

      case let .newColorGenerated(hexString):
        let color = ColorModel(hexString: hexString)
        state.color = .init(color: color)
        state.colors.insert(color, at: .zero)
        return .none
      }
    }
  )
