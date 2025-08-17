//
//  ColorFeature.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture

struct ColorFeatureState: Equatable {
  var colorHexString: String
  var loveCount = 0
}

enum ColorFeatureAction {
  case colorTapped
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

let colorFeatureReducer = AnyReducer<
  ColorFeatureState,
  ColorFeatureAction,
  ColorFeatureEnvironment
> { state, action, environment in
  switch action {
  case .colorTapped:
    state.loveCount += 1
    return .none

  case .generateButtonTapped:
    return environment.generateNewColor()
      .map(ColorFeatureAction.newColorGenerated)

  case let .newColorGenerated(hexString):
    state.colorHexString = hexString
    state.loveCount = 0
    return .none
  }
}
