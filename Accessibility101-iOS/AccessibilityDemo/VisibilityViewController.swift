//
//  VisibilityViewController.swift
//  AccessibilityDemo
//
//  Created by Sid on 20/06/2017.
//  Copyright © 2017 Picnic. All rights reserved.
//

import UIKit

class VisibilityViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel! {
        didSet {
            headerLabel.text = "UI is dynamic. Things appear and disappear based on interaction. How do we help the users understand what's going on?"
        }
    }

    @IBOutlet weak var announceLabel: UILabel! {
        didSet {
            announceLabel.text = "We can announce the changes ourselves"
        }
    }

    @IBOutlet weak var annoucementButton: UIButton! {
        didSet {
            annoucementButton.accessibilityHint = "Updates layout"
        }
    }

    private func updateAnnouncementButtontTitle() {
        let title = (anotherButton == nil) ? "Show Another" : "Hide Another"
        annoucementButton.setTitle(title, for: .normal)
    }

    @IBOutlet weak var hideElementsLabel: UILabel! {
        didSet {
            hideElementsLabel.text = "You may want to hide elements if the app is in accessibility mode"
        }
    }

    @IBOutlet weak var growingStackView: UIStackView!
    @IBOutlet weak var accessibleButton: UIButton! {
        didSet {
            accessibleButton.setTitle("I'm visible", for: .normal)
        }
    }

    @IBOutlet weak var invisibleButton: UIButton! {
        didSet {
            invisibleButton.setTitle("I'm not", for: .normal)
            invisibleButton.isHidden = UIAccessibilityIsVoiceOverRunning()
        }
    }

    @IBOutlet weak var inAccessibleButton: UIButton! {
        didSet {
            inAccessibleButton.setTitle("Or skip them", for: .normal)
        }
    }

    @IBOutlet weak var buttonsStackView: UIStackView! {
        didSet {
            buttonsStackView.accessibilityElements = [accessibleButton]
        }
    }

    private var anotherButton: UIButton?

    @IBAction func onAnnouncement(_ sender: Any) {

        if let anotherButton = anotherButton {
            growingStackView.removeArrangedSubview(anotherButton)
            self.anotherButton = nil
        } else {
            let anotherButton = UIButton(type: .system)
            anotherButton.setTitle("Another button", for: .normal)
            growingStackView.addArrangedSubview(anotherButton)
            self.anotherButton = anotherButton
        }

        updateAnnouncementButtontTitle()
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, anotherButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateAnnouncementButtontTitle()
    }
}
