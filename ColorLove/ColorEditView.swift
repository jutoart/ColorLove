//
//  ColorEditView.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture
import SwiftUI

struct ColorEditView: View {
  @Bindable var store: StoreOf<ColorEditFeature>

  var body: some View {
    NavigationStack {
      VStack {
        Color(hexString: store.colorHexString)
          .frame(height: 240)

        TextField("Name", text: $store.colorName)
          .textFieldStyle(.roundedBorder)
          .padding()

        Spacer()
      }
      .navigationTitle("Edit")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel", systemImage: "xmark") {
            store.send(.cancelButtonTapped)
          }
        }

        ToolbarItem(placement: .confirmationAction) {
          Button("Done", systemImage: "checkmark") {
            store.send(.doneButtonTapped)
          }
        }
      }
    }
  }
}

#Preview {
  ColorEditView(
    store: .init(initialState: .init(colorHexString: "006FFF", colorName: "")) {
      ColorEditFeature()
    }
  )
}
