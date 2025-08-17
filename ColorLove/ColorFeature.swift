//
//  ColorFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture

struct ColorFeatureState: Equatable {
  var colorHexString: String
  var colorName = ""
  var loveCount = 0

  var edit: ColorEditFeatureState?
}

enum ColorFeatureAction {
  case colorTapped
  case dismissEdit
  case edit(ColorEditFeatureAction)
  case editButtonTapped
  case generateButtonTapped
  case newColorGenerated(hexString: String)
}

struct ColorFeatureEnvironment {
  var generateNewColor: () -> EffectTask<String>

  static let live = Self(
    generateNewColor: {
      let hexNumber = UInt64.random(in: 0...0xFFFFFF)
      let hexString = String(hexNumber, radix: 16, uppercase: true)
      return .init(value: hexString)
    }
  )
}

let colorFeatureReducer = colorEditFeatureReducer
  .optional()
  .pullback(state: \.edit, action: /ColorFeatureAction.edit, environment: { _ in })
  .combined(
    with: AnyReducer<
      ColorFeatureState,
      ColorFeatureAction,
      ColorFeatureEnvironment
    > { state, action, environment in
      switch action {
      case .colorTapped:
        state.loveCount += 1
        return .none

      case .dismissEdit:
        state.edit = nil
        return .none

      case let .edit(.delegate(delegateAction)):
        switch delegateAction {
        case .dismiss:
          state.edit = nil
          return .none

        case let .updateColor(name):
          state.colorName = name
          state.edit = nil
          return .none
        }

      case .edit:
        return .none

      case .editButtonTapped:
        state.edit = .init(colorHexString: state.colorHexString, colorName: state.colorName)
        return .none

      case .generateButtonTapped:
        return environment.generateNewColor()
          .map(ColorFeatureAction.newColorGenerated)

      case let .newColorGenerated(hexString):
        state.colorHexString = hexString
        state.colorName = ""
        state.loveCount = 0
        return .none
      }
    }
  )



