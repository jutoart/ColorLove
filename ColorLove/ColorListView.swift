//
//  ColorListView.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import ComposableArchitecture
import SwiftUI

struct ColorListView: View {
  @Bindable var store: StoreOf<ColorListFeature>

  var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      List(store.colors) { color in
        NavigationLink(
          state: ColorListFeature.Path.State.color(.init(colorHexString: color.hexString))
        ) {
          HStack {
            Text(color.name.isEmpty ? "#\(color.hexString)" : color.name)
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .background(.thinMaterial)
              .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))

            Spacer()

            Label("\(color.loveCount)", systemImage: "heart.fill")
              .labelIconToTitleSpacing(4)
              .font(.caption)
              .foregroundStyle(.red)
          }
          .padding()
          .frame(height: 48)
          .background {
            LinearGradient(
              gradient: .init(colors: [
                .init(hexString: color.hexString),
                .init(hexString: color.hexString),
                .white
              ]),
              startPoint: .leading,
              endPoint: .trailing
            )
          }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(.init())
      }
      .listStyle(.grouped)
      .navigationLinkIndicatorVisibility(.hidden)
      .environment(\.defaultMinListRowHeight, 48)
      .navigationTitle("Color Love")
      .toolbar {
        ToolbarItemGroup(placement: .primaryAction) {
          Button("Generate", systemImage: "sparkles") {
            store.send(.generateButtonTapped)
          }
        }
      }
    } destination: { store in
      switch store.case {
        case let .color(store):
          ColorView(store: store)
        }
    }
  }
}

#Preview {
  ColorListView(
    store: .init(
      initialState: ColorListFeature.State(colors: [
        .init(hexString: "006FFF"),
        .init(hexString: "FF6F00")
      ])
    ) {
      ColorListFeature()
    }
  )
}
