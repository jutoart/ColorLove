//
//  ColorFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture

struct ColorFeatureState: Equatable {
  var color: ColorModel

  var edit: ColorEditFeatureState?
}

enum ColorFeatureAction {
  case colorTapped
  case delegate(Delegate)
  case dismissEdit
  case edit(ColorEditFeatureAction)
  case editButtonTapped

  enum Delegate {
    case updateColor(ColorModel)
  }
}

let colorFeatureReducer = colorEditFeatureReducer
  .optional()
  .pullback(state: \.edit, action: /ColorFeatureAction.edit, environment: { _ in })
  .combined(
    with: AnyReducer<
      ColorFeatureState,
      ColorFeatureAction,
      Void
    > { state, action, _ in
      switch action {
      case .colorTapped:
        state.color.loveCount += 1
        return .send(.delegate(.updateColor(state.color)))

      case .delegate:
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
          state.color.name = name
          state.edit = nil
          return .send(.delegate(.updateColor(state.color)))
        }

      case .edit:
        return .none

      case .editButtonTapped:
        state.edit = .init(colorHexString: state.color.hexString, colorName: state.color.name)
        return .none
      }
    }
  )



