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
    func trunc(maximumFractionDigits: Int = 2) -> String {
        guard let floatSelf = Float(self) else { return self }
        let s = String(format: "%.\(maximumFractionDigits)f", floatSelf)
        for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
            if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
                return String(s[..<s.index(s.endIndex, offsetBy: i)])
            }
        }
        return String(s[..<s.index(s.endIndex, offsetBy: -maximumFractionDigits - 1)])
    }
}
