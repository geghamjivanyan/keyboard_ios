import UIKit
import KeyboardKit

class KeyboardView: UIView {
    
    // MARK: - Properties
    
    private let layout = KeyboardLayout()
    private var keyButtons: [[UIButton]] = []
    weak var delegate: KeyboardViewController?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .systemGray5
        createKeyButtons()
    }
    
    private func createKeyButtons() {
        for (rowIndex, row) in layout.rows.enumerated() {
            var buttonRow: [UIButton] = []
            
            for (columnIndex, key) in row.enumerated() {
                let button = createKeyButton(for: key, at: rowIndex, columnIndex)
                buttonRow.append(button)
                addSubview(button)
            }
            
            keyButtons.append(buttonRow)
        }
    }
    
    private func createKeyButton(for key: String, at row: Int, columnIndex: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(key, for: .normal)
        button.backgroundColor = layout.keyColor(for: key)
        button.setTitleColor(layout.keyTextColor(for: key), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
        
        // Set frame
        let frame = layout.frameForKey(at: row, column: columnIndex, in: self)
        button.frame = frame
        
        return button
    }
    
    // MARK: - Actions
    
    @objc private func keyPressed(_ sender: UIButton) {
        guard let key = sender.title(for: .normal) else { return }
        
        switch key {
        case "⌫":
            delegate?.deleteBackward()
        case "space":
            delegate?.insertText(" ")
        case "return":
            delegate?.insertText("\n")
        case "⇧":
            // Handle shift key
            break
        case "123":
            // Handle number key
            break
        case "🌐":
            // Handle globe key
            break
        default:
            delegate?.insertText(key)
        }
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateButtonFrames()
    }
    
    private func updateButtonFrames() {
        for (rowIndex, row) in keyButtons.enumerated() {
            for (columnIndex, button) in row.enumerated() {
                button.frame = layout.frameForKey(at: rowIndex, column: columnIndex, in: self)
            }
        }
    }
} 