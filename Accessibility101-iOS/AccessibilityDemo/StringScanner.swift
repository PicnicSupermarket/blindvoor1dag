//
//  StringScanner.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import Foundation

struct StringScanner {
    static func rangeBetweenIndices(startIt: String.Index, end endIt: String.Index, inString string: String) -> NSRange {
        let start = string.characters.distance(from: string.startIndex, to: startIt)
        let end = string.characters.distance(from: string.startIndex, to: endIt)
        return NSRange(location: start, length: end-start)
    }

    static func parseMoneyInString(_ string: String) -> MoneyRange {

        var currencyRange: NSRange?
        var dollarRange: NSRange?
        var seperatorRange: NSRange?
        var centRange: NSRange?

        var lastIndex = string.characters.startIndex
        for index in string.characters.indices {
            switch string[index] {
            case " " where string.substring(with: lastIndex ..< index).contains(String(MoneyFormatter.euro)):
                currencyRange = rangeBetweenIndices(startIt: lastIndex, end: index, inString: string)
                lastIndex = string.characters.index(index, offsetBy: 1) /* skip the whitespace */

            case "." where !string.substring(with: lastIndex ..< index).characters.isEmpty:
                dollarRange = rangeBetweenIndices(startIt: lastIndex, end: index, inString: string)
                lastIndex = index

            default:
                continue
            }
        }

        if string[lastIndex] == "." {
            seperatorRange = rangeBetweenIndices(startIt: lastIndex, end: string.characters.index(lastIndex, offsetBy: 1), inString: string)
            lastIndex = string.characters.index(lastIndex, offsetBy: 1) /* skip the . */
        }

        centRange = rangeBetweenIndices(startIt: lastIndex, end: string.endIndex, inString: string)

        return MoneyRange(currency: currencyRange, dollars: dollarRange, seperator: seperatorRange, cents: centRange)
    }
}
