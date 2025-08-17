//
//  Color+Extension.swift
//  ColorLove
//
//  Created by Art Huang on 2025/8/17.
//

import SwiftUI

extension Color {
  init(hexString: String) {
    let hexNumber = UInt64(hexString, radix: 16)!
    let red = Double((hexNumber & 0xFF0000) >> 16) / 255
    let green = Double((hexNumber & 0x00FF00) >> 8) / 255
    let blue = Double(hexNumber & 0x0000FF) / 255
    self.init(red: red, green: green, blue: blue)
  }
}
