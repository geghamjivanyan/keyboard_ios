import UIKit
import KeyboardKit

class KeyboardViewController: KeyboardInputViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboard()
    }
    
    private func setupKeyboard() {
        // Configure keyboard appearance
        keyboardAppearance = .light
        
        // Set up keyboard layout
        let layout = KeyboardLayout()
        keyboardLayout = layout
        
        // Configure keyboard behavior
        keyboardBehavior = .standard
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Additional layout setup if needed
    }
    
    // MARK: - Keyboard Input Handling
    
    override func insertText(_ text: String) {
        textDocumentProxy.insertText(text)
    }
    
    override func deleteBackward() {
        textDocumentProxy.deleteBackward()
    }
    
    // MARK: - Keyboard Actions
    
    @objc func handleKeyPress(_ sender: UIButton) {
        guard let key = sender.title(for: .normal) else { return }
        insertText(key)
    }
} 