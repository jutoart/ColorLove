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
    var colorName = ""
    var loveCount = 0

    @Presents var edit: ColorEditFeature.State?
  }

  enum Action {
    case colorTapped
    case edit(PresentationAction<ColorEditFeature.Action>)
    case editButtonTapped
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .colorTapped:
        state.loveCount += 1
        return .none

      case let .edit(.presented(.delegate(delegateAction))):
        switch delegateAction {
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
      }
    }
    .ifLet(\.$edit, action: \.edit) {
      ColorEditFeature()
    }
  }
}
