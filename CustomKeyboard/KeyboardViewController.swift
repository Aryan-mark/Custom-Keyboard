//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by Aryan Jaiswal on 24/12/25.
import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {

    private var hostingController: UIHostingController<KeyboardView>?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a hosting controller to embed SwiftUI views
        let keyboardView = KeyboardView(onKeyPress: { [weak self] key in
            self?.insertText(key)
        })
        hostingController = UIHostingController(rootView: keyboardView)

        guard let hostingController = hostingController else { return }

        // Add the hosting controller's view to the input view controller's view hierarchy
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        // Set up constraints to make the hosting view fill the entire view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Ensure the hosting controller's view is properly sized
        hostingController?.view.frame = view.bounds
    }

    private func insertText(_ text: String) {
        switch text {
        case "⌫": // Backspace
            textDocumentProxy.deleteBackward()
        case "⏎": // Return
            textDocumentProxy.insertText("\n")
        case "␣": // Space
            textDocumentProxy.insertText(" ")
        default:
            textDocumentProxy.insertText(text)
        }
    }
}
