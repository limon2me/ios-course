//
//  FontBuilder.swift
//  ios-cource
//
//  Created by v.khabarov on 18.05.2024.
//

import UIKit

class FontBuilder {

    static func sfProRoundedFont(_ size: CGFloat) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: .semibold)
        let font: UIFont

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }

        return font
    }

    private init() { }
}
