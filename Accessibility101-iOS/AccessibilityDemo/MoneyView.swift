//
//  MoneyView.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import UIKit

enum MoneyAccessibilityMode {
    case none
    case basic
    case advanced
}

@IBDesignable class MoneyView: UIView {

    fileprivate let moneyLabel = UILabel()
    private let formatter: MoneyFormatter = {
        let attributes = MoneyFormatter.AttributeStyle.medium.attributes
        return MoneyFormatter(formattingStyle: .currencySign, trimCents: false, attributes: attributes)
    }()

    var money: Money = Money.zero {
        didSet {
            moneyLabel.attributedText = formatter.attributedString(from: money)
        }
    }

    var mode: MoneyAccessibilityMode = .basic

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func setUp() {
        addSubview(moneyLabel)
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        let viewsDict: [String: Any] = ["L": moneyLabel]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[L]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[L]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))

        moneyLabel.textAlignment = .center


        layer.cornerRadius = 4.0
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2.0

    }
}

extension MoneyView {
    override func accessibilityIncrement() {
        self.money = money + Money(cents: 50)
    }

    override func accessibilityDecrement() {
        self.money = money - Money(cents: 50)
    }
}

extension MoneyView {
    override var isAccessibilityElement: Bool {
        set {}
        get { return true }
    }

    override var accessibilityLabel: String? {
        set {}
        get { return money.voiceOverText }
    }

    override var accessibilityTraits: UIAccessibilityTraits {
        set {}
        get { return super.accessibilityTraits | UIAccessibilityTraitAdjustable }
    }

    override var accessibilityHint: String? {
        set {}
        get { return "Swipe up or down to change price" }
    }
}
