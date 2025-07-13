//
//  Color.swift
//  Running
//
//  Created by 류창휘 on 7/13/25.
//

import Foundation
import SwiftUICore

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension Color {
    static let color7442FF = Color(hex: 0x7442FF)
    static let colorE6E0FF = Color(hex: 0xE6E0FF)
}
