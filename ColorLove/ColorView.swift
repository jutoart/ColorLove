//
//  ColorView.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture
import SwiftUI

struct ColorView: View {
  @Bindable var store: StoreOf<ColorFeature>

  var body: some View {
    Color(hexString: store.colorHexString)
      .aspectRatio(contentMode: .fit)
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
      .overlay(alignment: .bottomTrailing) {
        Label("\(store.loveCount)", systemImage: "heart.fill")
          .foregroundStyle(.red)
          .padding(.horizontal, 8)
          .padding(.vertical, 4)
          .background(.regularMaterial)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          .padding()
      }
      .onTapGesture {
        store.send(.colorTapped)
      }
      .padding(80)
      .navigationTitle(store.colorName.isEmpty ? "#\(store.colorHexString)" : store.colorName)
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button("Edit", systemImage: "pencil") {
            store.send(.editButtonTapped)
          }
        }
      }
      .sheet(item: $store.scope(state: \.edit, action: \.edit)) {
        ColorEditView(store: $0)
      }
  }
}

#Preview {
  NavigationStack {
    ColorView(
      store: .init(initialState: .init(colorHexString: "006FFF")) {
        ColorFeature()
      }
    )
  }
}
