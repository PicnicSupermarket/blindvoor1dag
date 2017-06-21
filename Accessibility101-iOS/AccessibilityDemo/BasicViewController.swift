//
//  BasicViewController.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {

    @IBOutlet weak var imageLabel: UILabel! {
        didSet {
            imageLabel.text = "Basic accessibility is easy! Regular text is read fully by the VoiceOver. Images are skipped by default"
        }
    }

    @IBOutlet weak var buttonsLabel: UILabel! {
        didSet {
            buttonsLabel.text = "How about some buttons?"
        }
    }
    @IBOutlet weak var buttonsFooterLabel: UILabel! {
        didSet {
            buttonsFooterLabel.text = "Unlabelled buttons? Don't forget to add a accessibility label to image buttons"
        }
    }

    @IBOutlet weak var componentsLabel: UILabel! {
        didSet {
            componentsLabel.text = "Other components can also be changed based on description"
        }
    }

    @IBOutlet weak var textButton: UIButton! {
        didSet {
            textButton.setTitle("Click Me!", for: .normal)
            textButton.accessibilityHint = "Tap to do something"
        }
    }

    @IBOutlet weak var imageButton: UIButton! {
        didSet {
            imageButton.setTitle(nil, for: .normal)
            imageButton.setImage(UIImage(named: "ic_undo"), for: .normal)
            imageButton.accessibilityLabel = "Undo"
            imageButton.accessibilityHint = "Tap to undo"
        }
    }
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.accessibilityHint = "Drag to change something"
            slider.accessibilityValue = "Value, \(slider.value)"
        }
    }

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.accessibilityHint = "Enter some text"
        }
    }

    @IBAction func onSliderUpdate(_ sender: Any) {
        slider.accessibilityValue = "Value, \(slider.value)"
    }

    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityElements = [
imageLabel, buttonsLabel, buttonsFooterLabel, textButton, imageButton, componentsLabel, slider, textField
        ]
    }
}

extension BasicViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        topConstraint.constant = -200.0
        view.layoutIfNeeded()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topConstraint.constant = 32.0
        view.layoutIfNeeded()
        textField.resignFirstResponder()
        return true
    }
}

