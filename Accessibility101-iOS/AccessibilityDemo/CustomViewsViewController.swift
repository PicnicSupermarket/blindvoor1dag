//
//  CustomViewsViewController.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import UIKit

class CustomViewsViewController: UIViewController {

    @IBOutlet weak var plainMoneyLabel: UILabel! {
        didSet {
            plainMoneyLabel.text = "Custom views might require extra care. Take this price view as an example"
        }
    }

    @IBOutlet weak var plainMoneyView: MoneyView! {
        didSet {
            plainMoneyView.money = Money(dollars: 2, cents: 49)
            plainMoneyView.mode = .none
        }
    }

    @IBOutlet weak var formattedMoneyLabel: UILabel! {
        didSet {
            formattedMoneyLabel.text = "First of all, make sure the content description makes sense."
        }
    }

    @IBOutlet weak var formattedMoneyView: MoneyView! {
        didSet {
            formattedMoneyView.money = Money(dollars: 10, cents: 1)
            formattedMoneyView.mode = .basic
        }
    }

    @IBOutlet weak var hintedMoneyLabel: UILabel! {
        didSet {
            hintedMoneyLabel.text = "Then describe the view actions to make it more usable"
        }
    }

    @IBOutlet weak var hintedMoneyView: MoneyView! {
        didSet {
            hintedMoneyView.money = Money(dollars: 25, cents: 99)
            hintedMoneyView.mode = .advanced
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
