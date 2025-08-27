//
//  ColorListView.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/18.
//

import ComposableArchitecture
import SwiftUI

struct ColorListView: View {
  let store: Store<ColorListFeatureState, ColorListFeatureAction>

  var body: some View {
    NavigationStack {
      WithViewStore(store, observe: { $0 }) { viewStore in
        List(viewStore.colors.sorted()) { color in
          Button {
            viewStore.send(.colorTapped(hexString: color.hexString))
          } label: {
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
          .buttonStyle(.plain)
          .listRowSeparator(.hidden)
          .listRowInsets(.init())
        }
        .listStyle(.grouped)
        .environment(\.defaultMinListRowHeight, 48)
        .navigationTitle("Color Love")
        .toolbar {
          ToolbarItemGroup(placement: .primaryAction) {
            Button("Generate", systemImage: "sparkles") {
              viewStore.send(.generateButtonTapped)
            }
          }
        }
        .navigationDestination(
          isPresented: .init(
            get: {
              viewStore.color != nil
            },
            set: {
              if $0 == false {
                viewStore.send(.dismissColor)
              }
            }
          )
        ) {
          IfLetStore(store.scope(state: \.color, action: ColorListFeatureAction.color)) {
            ColorView(store: $0)
          }
        }
      }
    }
  }
}

#Preview {
  ColorListView(
    store: .init(
      initialState: ColorListFeatureState(colors: [
        .init(hexString: "006FFF"),
        .init(hexString: "FF6F00")
      ]),
      reducer: colorListFeatureReducer,
      environment: .live
    )
  )
}
