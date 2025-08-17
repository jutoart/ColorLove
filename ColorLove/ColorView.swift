//
//  ColorView.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture
import SwiftUI

struct ColorView: View {
  let store: Store<ColorFeatureState, ColorFeatureAction>

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      Color(hexString: viewStore.colorHexString)
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(alignment: .bottomTrailing) {
          Label("\(viewStore.loveCount)", systemImage: "heart.fill")
            .foregroundStyle(.red)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .padding()
        }
        .onTapGesture {
          viewStore.send(.colorTapped)
        }
        .overlay(alignment: .top) {
          Text("#\(viewStore.colorHexString)")
            .offset(x: .zero, y: -32)
        }
        .padding(80)
    }
  }
}

#Preview {
  ColorView(
    store: .init(
      initialState: .init(colorHexString: "006FFF"),
      reducer: colorFeatureReducer,
      environment: ()
    )
  )
}
