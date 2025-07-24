//
//  CommonButton.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

class CommonButton: UIButton {
    enum ButtonState {
        case normal
        case highligted
        case disabled
    }

    override var isHighlighted: Bool {
        didSet {
            buttonStateChanged()
        }
    }

    override var isSelected: Bool {
        didSet {
            buttonStateChanged()
        }
    }

    override var isEnabled: Bool {
        didSet {
            buttonStateChanged()
        }
    }

    override var accessibilityIdentifier: String? {
        get {
            if let id = super.accessibilityIdentifier {
                return id
            }

            return findAccessibilityLabel()
        }
        set { super.accessibilityIdentifier = newValue }
    }

    override var accessibilityLabel: String? {
        get {
            if let id = super.accessibilityLabel {
                return id
            }

            return findAccessibilityIdentifier()
        }
        set { super.accessibilityLabel = newValue }
    }

    var useDefaultHighlight = false
    var onAction: (() -> Void)? {
        didSet {
            if onAction != nil {
                startListeningButtonAction()
            } else {
                stopListeningButtonAction()
            }
        }
    }

    var onActionWithSender: ((CommonButton) -> Void)? {
        didSet {
            if onActionWithSender != nil {
                startListeningButtonAction()
            } else {
                stopListeningButtonAction()
            }
        }
    }

    private var isListeningAction = false

    func simplifiedButtonState() -> ButtonState {
        guard isEnabled else { return .disabled }
        return isHighlightedOrSelected() ? .highligted : .normal
    }

    func isHighlightedOrSelected() -> Bool { isHighlighted || isSelected }

    func buttonStateChanged() {
        if useDefaultHighlight {
            UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions.beginFromCurrentState) { [weak self] in
                guard let self else { return }
                self.transform = self.isHighlightedOrSelected() ?
                    CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95) :
                    CGAffineTransform.identity
            }
        }
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        accessibilityIdentifier = title
    }

    override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        guard onAction != nil || onActionWithSender != nil else {
            fatalError("Do not add button targets directly, use onAction block instead.")
        }

        super.sendAction(action, to: target, for: event)
    }

    private func startListeningButtonAction() {
        guard isListeningAction == false else { return }
        isExclusiveTouch = true
        isListeningAction = true
        addTarget(
            self,
            action: #selector(buttonSelected(sender:)),
            for: UIControl.Event.primaryActionTriggered
        )
    }

    private func stopListeningButtonAction() {
        guard isListeningAction else { return }
        isListeningAction = false
        removeTarget(
            self,
            action: #selector(buttonSelected(sender:)),
            for: UIControl.Event.primaryActionTriggered
        )
    }

    @objc func buttonSelected(sender: Any) {
        onAction?()
        onActionWithSender?(self)
    }
}
