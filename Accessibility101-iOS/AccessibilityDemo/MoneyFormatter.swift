//
//  MoneyFormatter.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import Foundation
import UIKit

struct MoneyFormatter {

    static let euro: Character = "\u{20AC}"
    static let nbsp: Character = "\u{00a0}"

    enum FormattingStyle {
        case amount         // e.g. `5.00`
        case currencySign   // e.g. `€ 5.00`
        case currencyName   // e.g. `5.00 euro`
    }

    enum AttributeStyle: String {
        case small = "Small"
        case medium = "Medium"
        case large = "Large"
        case extraLarge = "ExtraLarge"

        var attributes: MoneyLabelRenderingAttributes {
            switch self {
            case .small:
                return MoneyLabelRenderingAttributes(
                    symbolsFont: UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold),
                    dollarsFont: UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold),
                    centsFont: UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightBold),
                    baselineOffset: 6,
                    decimalOffset: -4
                )
            case .medium:
                return MoneyLabelRenderingAttributes(
                    symbolsFont: UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightBold),
                    dollarsFont: UIFont.systemFont(ofSize: 20.0, weight: UIFontWeightBold),
                    centsFont: UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightBold),
                    baselineOffset: 8,
                    decimalOffset: -4
                )
            case .large:
                return MoneyLabelRenderingAttributes(
                    symbolsFont: UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightBold),
                    dollarsFont: UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightBold),
                    centsFont: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold),
                    baselineOffset: 8,
                    decimalOffset: -5
                )
            case .extraLarge:
                return MoneyLabelRenderingAttributes(
                    symbolsFont: UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightMedium),
                    dollarsFont: UIFont.systemFont(ofSize: 30.0, weight: UIFontWeightMedium),
                    centsFont: UIFont.systemFont(ofSize: 18.0, weight: UIFontWeightMedium),
                    baselineOffset: 8,
                    decimalOffset: -5
                )
            }
        }
    }

    private let formattingStyle: FormattingStyle
    private let attributes: MoneyLabelRenderingAttributes
    private let trimCents: Bool

    init(formattingStyle: FormattingStyle, trimCents: Bool, attributes: MoneyLabelRenderingAttributes) {
        self.formattingStyle = formattingStyle
        self.attributes = attributes
        self.trimCents = trimCents
    }

    init(formattingStyle: FormattingStyle = .currencySign, trimCents: Bool = false, attributeStyle: AttributeStyle = .large) {
        self.init(formattingStyle: formattingStyle, trimCents: trimCents, attributes: attributeStyle.attributes)
    }

    func string(from money: Money) -> String {
        let dollars = money.dollarsFractionString
        let cents = money.centsFractionString
        let amount = trimCents && cents == "00" ? "\(dollars)" : "\(dollars).\(cents)"

        switch formattingStyle {
        case .amount:
            return amount

        case .currencySign:
            return "\(MoneyFormatter.euro)\(MoneyFormatter.nbsp)\(amount)"

        case .currencyName:
            let currencyName = "euro"
            return "\(amount)\(MoneyFormatter.nbsp)\(currencyName)"
        }
    }

    func attributedString(from money: Money) -> NSMutableAttributedString {
        let rawString = string(from: money)
        let range = StringScanner.parseMoneyInString(rawString)

        let attrString = NSMutableAttributedString(
            string: rawString,
            attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 22.0, weight: UIFontWeightBold)]
        )

        attrString.beginEditing()

        if let currencyRange = range.currency {
            attrString.addAttributes([NSFontAttributeName: attributes.symbolsFont], range: currencyRange)
        }
        if let dollarRange = range.dollars {
            attrString.addAttributes([NSFontAttributeName: attributes.dollarsFont], range: dollarRange)
        }
        if let seperatorRange = range.seperator {
            attrString.addAttributes([NSFontAttributeName: attributes.symbolsFont, NSKernAttributeName: attributes.decimalOffset], range: seperatorRange)
        }
        if let centRange = range.cents {
            attrString.addAttributes([NSFontAttributeName: attributes.centsFont, NSBaselineOffsetAttributeName: attributes.baselineOffset], range: centRange)
        }
        attrString.endEditing()
        
        return attrString
    }
}
