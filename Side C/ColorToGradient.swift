//
//  ColorToGradient.swift
//  Side C
//
//  Created by Daniel Marsh on 4/5/26.
//

import SwiftUI

struct ColorToGradient {
    static func gradient(from color: Color) -> LinearGradient {
        let uiColor = UIColor(color)
        let darker = uiColor.darker(by: 0.20)
        
        return LinearGradient(
            gradient: Gradient(colors: [
                color,
                Color(darker)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

extension UIColor {
    func darker(by amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(
                hue: hue,
                saturation: saturation,
                brightness: max(brightness - amount, 0),
                alpha: alpha
            )
        }
        
        return self
    }
}

//#Preview {
//    ColorToGradient()
//}
