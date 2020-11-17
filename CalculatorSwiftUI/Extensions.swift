//
//  Extensions.swift
//  CalculatorSwiftUI
//
//  Created by Kirill Fedin on 15.11.2020.
//

import Foundation
import UIKit
import SwiftUI

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Color {    
    public static let newPurple = Color(red: 132 / 255, green: 108 / 255, blue: 250 / 255)
}

extension String {
    var isNumber: Bool {
        let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        return numbers.contains(self)
    }
    var clean: String {
        return self.hasSuffix(".0") ? self.replacingOccurrences(of: ".0", with: "") : self
    }
}
