//
//  MoneyLabelRenderingAttributes.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import UIKit

/**
 The rendering attributes for a MoneyLabel
 */
struct MoneyLabelRenderingAttributes {
    /**
     The font to use for the Symbols, e.g. the separator
     */
    let symbolsFont: UIFont

    /**
     The font to use for the Dollars fraction
     */
    let dollarsFont: UIFont

    /**
     The font to use for the Cents fraction
     */
    let centsFont: UIFont

    /**
     The baseline offset of the Cents fraction
     */
    let baselineOffset: NSNumber

    /**
     The horizontal offset of the Cents fraction
     */
    let decimalOffset: NSNumber
}
