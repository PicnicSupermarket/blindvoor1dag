//
//  MoneyRange.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import Foundation

struct MoneyRange {
    let currency: NSRange?
    let dollars: NSRange?
    let seperator: NSRange?
    let cents: NSRange?

    init(currency: NSRange?, dollars: NSRange?, seperator: NSRange?, cents: NSRange?) {
        self.currency = currency
        self.dollars = dollars
        self.seperator = seperator
        self.cents = cents
    }
}

func == (lhs: MoneyRange, rhs: MoneyRange) -> Bool {
    if let lhsCurrency = lhs.currency, let rhsCurrency = rhs.currency, !NSEqualRanges(lhsCurrency, rhsCurrency) {
        return false
    }
    if let lhsDollars = lhs.dollars, let rhsDollars = rhs.dollars, !NSEqualRanges(lhsDollars, rhsDollars) {
        return false
    }
    if let lhsSeperator = lhs.seperator, let rhsSeperator = rhs.seperator, !NSEqualRanges(lhsSeperator, rhsSeperator) {
        return false
    }
    if let lhsCents = lhs.cents, let rhsCents = rhs.cents, !NSEqualRanges(lhsCents, rhsCents) {
        return false
    }
    return true
}

extension MoneyRange: Equatable {}

extension MoneyRange: CustomStringConvertible {
    var description: String {
        var str = ""
        if let currency = currency {
            str += "currency: " + NSStringFromRange(currency)
        }
        if let dollars = dollars {
            str += " dollars: " + NSStringFromRange(dollars)
        }
        if let seperator = seperator {
            str += " seperator: " + NSStringFromRange(seperator)
        }
        if let cents = cents {
            str += " cents " + NSStringFromRange(cents)
        }
        return str
    }
}
