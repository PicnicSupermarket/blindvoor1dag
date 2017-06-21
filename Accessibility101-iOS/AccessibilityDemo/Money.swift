//
//  Money.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import Foundation

public struct Money {

    /// Returns the equivalent of no money
    public static var zero: Money {
        return Money(cents: 0)
    }

    /// The amount of money, expressed in cents
    public let cents: Int

    /// The amount of money, expressed in dollars, e.g. 100 cents represent 1 dollar
    // TODO: We need a better name for this
    public var dollars: Double {
        return Double(cents)/100.0
    }

    /// The dollar fraction for this amount of Money. E.g. `Money(cents: 125)` will return 1
    public var dollarsFraction: Int {
        return Int(modf(dollars).0)
    }

    /// The cents fraction for this amount of Money. E.g. `Money(cents: 125) will return 25.
    public var centsFraction: Int {
        return abs(cents - dollarsFraction * 100)
    }

    /// String representation of the dollar fraction for this amount of Money.
    public var dollarsFractionString: String {
        //if dollars == 0 and we have a negative cents (e.g. missing product), we put a "-" before.
        //if dollar > 0 and cents < 0, the "-" will already show up.
        return cents < 0 && dollarsFraction == 0 ? "-\(dollarsFraction)": "\(dollarsFraction)"
    }

    /// String representation of the cents fraction for this amount of Money
    public var centsFractionString: String {
        return String(format: "%02d", centsFraction)
    }

    // MARK: - Initializers
    public init(dollars: Int, cents: Int) {
        self.init(cents: dollars * 100 + cents)
    }
    
    public init(cents: Int) {
        self.cents = cents
    }

    public init?(cents: Int?) {
        guard let cents = cents else {
            return nil
        }
        self.init(cents: cents)
    }
}

// MARK: - Protocol implementations -

// MARK: - Comparable
extension Money: Comparable {}

public func ==(lhs: Money, rhs: Money) -> Bool {
    return lhs.cents == rhs.cents
}

public func <=(lhs: Money, rhs: Money) -> Bool {
    return lhs.cents <= rhs.cents
}

public func >=(lhs: Money, rhs: Money) -> Bool {
    return lhs.cents >= rhs.cents
}

public func >(lhs: Money, rhs: Money) -> Bool {
    return lhs.cents > rhs.cents
}

public func <(lhs: Money, rhs: Money) -> Bool {
    return lhs.cents < rhs.cents
}

// MARK: - Overload the + and - function for Money

public func +(lhs: Money, rhs: Money) -> Money {
    return Money(cents: lhs.cents + rhs.cents)
}

public func -(lhs: Money, rhs: Money) -> Money {
    return Money(cents: lhs.cents - rhs.cents)
}

// MARK: - Overload the * for Money

public func *(lhs: Int, rhs: Money) -> Money {
    return Money(cents: lhs * rhs.cents)
}

// MARK: - Money + VoiceOverItem
extension Money: VoiceOverItem {

    public var voiceOverText: String {
        var components: [String] = []

        if dollarsFraction > 0 {
            components.append("\(dollarsFraction) \(MoneyFormatter.euro)")
        }

        if centsFraction > 0 {
            components.append("\(centsFraction)")
            if dollarsFraction == 0 {
                components.append("cents")
            }
        }

        guard !components.isEmpty else {
            return "\(0) \(MoneyFormatter.euro)"
        }
        
        return components.joined(separator: " ")
    }
}
