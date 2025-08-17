//
//  ColorEditView.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture
import SwiftUI

struct ColorEditView: View {
  let store: Store<ColorEditFeatureState, ColorEditFeatureAction>

  var body: some View {
    NavigationStack {
      WithViewStore(store, observe: { $0 }) { viewStore in
        VStack {
          Color(hexString: viewStore.colorHexString)
            .frame(height: 240)

          TextField("Name", text: viewStore.$colorName)
            .textFieldStyle(.roundedBorder)
            .padding()

          Spacer()
        }
        .navigationTitle("Edit")
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
              viewStore.send(.cancelButtonTapped)
            }
          }

          ToolbarItem(placement: .confirmationAction) {
            Button("Done", systemImage: "checkmark") {
              viewStore.send(.doneButtonTapped)
            }
          }
        }
      }
    }
  }
}

#Preview {
  ColorEditView(
    store: .init(
      initialState: .init(colorHexString: "006FFF", colorName: ""),
      reducer: colorEditFeatureReducer,
      environment: ()
    )
  )
}
