//
//  ColorModel.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

struct ColorModel: Equatable, Comparable, Identifiable {
  let hexString: String
  var name = ""
  var loveCount = 0

  var id: String {
    hexString
  }

  static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.loveCount > rhs.loveCount
  }
}
