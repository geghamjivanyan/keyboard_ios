import UIKit
import KeyboardKit

struct KeyboardLayout {
    
    // MARK: - Properties
    
    let rows: [[String]] = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["⇧", "Z", "X", "C", "V", "B", "N", "M", "⌫"],
        ["123", "🌐", "space", "return"]
    ]
    
    // MARK: - Layout Configuration
    
    var keySize: CGSize {
        return CGSize(width: 32, height: 40)
    }
    
    var keySpacing: CGFloat {
        return 6
    }
    
    var rowSpacing: CGFloat {
        return 8
    }
    
    // MARK: - Key Configuration
    
    func keyColor(for key: String) -> UIColor {
        switch key {
        case "space", "return":
            return .systemBlue
        case "⌫", "⇧":
            return .systemGray
        default:
            return .systemGray6
        }
    }
    
    func keyTextColor(for key: String) -> UIColor {
        switch key {
        case "space", "return", "⌫", "⇧":
            return .white
        default:
            return .black
        }
    }
    
    // MARK: - Layout Methods
    
    func frameForKey(at row: Int, column: Int, in view: UIView) -> CGRect {
        let x = CGFloat(column) * (keySize.width + keySpacing)
        let y = CGFloat(row) * (keySize.height + rowSpacing)
        return CGRect(x: x, y: y, width: keySize.width, height: keySize.height)
    }
} 