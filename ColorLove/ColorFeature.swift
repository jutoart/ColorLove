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
    var color: ColorModel {
      didSet {
        $colors.withLock {
          $0[id: color.id] = color
        }
      }
    }

    @Shared(.colors) var colors

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
        state.color.loveCount += 1
        return .none

      case let .edit(.presented(.delegate(delegateAction))):
        switch delegateAction {
        case let .updateColor(name):
          state.color.name = name
          state.edit = nil
          return .none
        }

      case .edit:
        return .none

      case .editButtonTapped:
        state.edit = .init(colorHexString: state.color.hexString, colorName: state.color.name)
        return .none
      }
    }
    .ifLet(\.$edit, action: \.edit) {
      ColorEditFeature()
    }
  }
}
