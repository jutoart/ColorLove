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
    NavigationStack {
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
          .padding(80)
          .navigationTitle(viewStore.colorName.isEmpty ? "#\(viewStore.colorHexString)" : viewStore.colorName)
          .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
              Button("Generate", systemImage: "sparkles") {
                viewStore.send(.generateButtonTapped)
              }

              Button("Edit", systemImage: "pencil") {
                viewStore.send(.editButtonTapped)
              }
            }
          }
          .sheet(
            isPresented: .init(
              get: {
                viewStore.edit != nil
              },
              set: {
                if $0 == false {
                  viewStore.send(.dismissEdit)
                }
              }
            )
          ) {
            IfLetStore(store.scope(state: \.edit, action: ColorFeatureAction.edit)) {
              ColorEditView(store: $0)
            }
          }
      }
    }
  }
}

#Preview {
  ColorView(
    store: .init(
      initialState: .init(colorHexString: "006FFF"),
      reducer: colorFeatureReducer,
      environment: .live
    )
  )
}
