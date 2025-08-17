//
//  ColorEditFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture

@Reducer
struct ColorEditFeature {
  @ObservableState
  struct State: Equatable {
    var colorHexString: String
    var colorName: String
  }

  enum Action: BindableAction {
    case binding(BindingAction<State>)
    case cancelButtonTapped
    case delegate(Delegate)
    case doneButtonTapped

    @CasePathable
    enum Delegate: Equatable {
      case updateColor(name: String)
    }
  }

  var body: some ReducerOf<Self> {
    BindingReducer()

    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .cancelButtonTapped:
        return .run { _ in
          @Dependency(\.dismiss) var dismiss
          await dismiss()
        }

      case .delegate:
        return .none

      case .doneButtonTapped:
        return .send(.delegate(.updateColor(name: state.colorName)))
      }
    }
  }
}
