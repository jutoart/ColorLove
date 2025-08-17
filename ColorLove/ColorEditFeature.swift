//
//  ColorEditFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture

struct ColorEditFeatureState: Equatable {
  var colorHexString: String
  @BindingState var colorName: String
}

enum ColorEditFeatureAction: BindableAction {
  case binding(BindingAction<ColorEditFeatureState>)
  case cancelButtonTapped
  case delegate(Delegate)
  case doneButtonTapped

  enum Delegate: Equatable {
    case dismiss
    case updateColor(name: String)
  }
}

let colorEditFeatureReducer = AnyReducer<
  ColorEditFeatureState,
  ColorEditFeatureAction,
  Void
> { state, action, _ in
  switch action {
  case .binding:
    return .none

  case .cancelButtonTapped:
    return .send(.delegate(.dismiss))

  case .delegate:
    return .none

  case .doneButtonTapped:
    return .send(.delegate(.updateColor(name: state.colorName)))
  }
}
.binding()
