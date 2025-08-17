//
//  SharedKeys.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/18.
//

import IdentifiedCollections
import Sharing

extension SharedReaderKey where Self == InMemoryKey<IdentifiedArrayOf<ColorModel>>.Default {
  static var colors: Self {
    Self[.inMemory("colors"), default: []]
  }
}
