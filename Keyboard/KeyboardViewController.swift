import UIKit

final class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    private let mainTextTransformer = MainTextTransformer()

    // Структура для клавиши
    struct Key {
        let english: String
        let arabic: String
        let color: UIColor
        let action: KeyAction?
        
        init(english: String, arabic: String, color: UIColor, action: KeyAction? = nil) {
            self.english = english
            self.arabic = arabic
            self.color = color
            self.action = action
        }
    }
    
    enum KeyAction {
        case delete
        case switchKeyboard
        case dot
        case space
        case enter
    }
    
    // Цвета
    let WHITE = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    let YELLOW = UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)
    let RED = UIColor(red: 240/255, green: 200/255, blue: 200/255, alpha: 1.0)
    let PURPLE = UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)
    let GREEN = UIColor(red: 200/255, green: 240/255, blue: 200/255, alpha: 1.0)
    let BLUE = UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0)
    
    var currentKeyboard = 1
    var keyboardButtons: [[UIButton]] = []
    
    // Раскладки клавиатур как свойства класса
    let keyboard1: [[Key]] = [
        [
            Key(english: "a", arabic: "", color: UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0), action: .delete),
            Key(english: "b", arabic: "تشكيل", color: UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0), action: .switchKeyboard),
            Key(english: "c", arabic: "ل", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "d", arabic: "َ", color: UIColor(red: 240/255, green: 200/255, blue: 200/255, alpha: 1.0)),
            Key(english: "e", arabic: "ُ", color: UIColor(red: 240/255, green: 200/255, blue: 200/255, alpha: 1.0)),
            Key(english: "f", arabic: "ِ", color: UIColor(red: 240/255, green: 200/255, blue: 200/255, alpha: 1.0))
        ],
        [
            Key(english: "g", arabic: "ف", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "h", arabic: "ن", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "i", arabic: "ر", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "j", arabic: "س", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "k", arabic: "ء", color: UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0)),
            Key(english: "l", arabic: "•", color: UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0), action: .dot)
        ],
        [
            Key(english: "m", arabic: "م", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "n", arabic: "ٮ", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "o", arabic: "د", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "p", arabic: "ص", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "q", arabic: "ح", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "r", arabic: "ه", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0))
        ],
        [
            Key(english: "s", arabic: "ـــ", color: UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0), action: .space),
            Key(english: "t", arabic: "ط", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "u", arabic: "ك", color: UIColor(red: 200/255, green: 240/255, blue: 200/255, alpha: 1.0)),
            Key(english: "v", arabic: "ق", color: UIColor(red: 200/255, green: 240/255, blue: 200/255, alpha: 1.0)),
            Key(english: "w", arabic: "ع", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "x", arabic: "↵", color: UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0), action: .enter)
        ]
    ]

    let keyboard2: [[Key]] = [
        [
            Key(english: "a", arabic: "", color: UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0), action: .delete),
            Key(english: "b", arabic: "إهمال", color: UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0), action: .switchKeyboard),
            Key(english: "c", arabic: "ل", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "d", arabic: "ا", color: UIColor(red: 240/255, green: 200/255, blue: 200/255, alpha: 1.0)),
            Key(english: "e", arabic: "و", color: UIColor(red: 240/255, green: 200/255, blue: 200/255, alpha: 1.0)),
            Key(english: "f", arabic: "ي", color: UIColor(red: 240/255, green: 200/255, blue: 200/255, alpha: 1.0))
        ],
        [
            Key(english: "g", arabic: "ف", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "h", arabic: "ن", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "i", arabic: "ر", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "j", arabic: "س", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "k", arabic: "ء", color: UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0)),
            Key(english: "l", arabic: "•", color: UIColor(red: 200/255, green: 210/255, blue: 250/255, alpha: 1.0), action: .dot)
        ],
        [
            Key(english: "m", arabic: "م", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "n", arabic: "ٮ", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "o", arabic: "د", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "p", arabic: "ص", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "q", arabic: "ح", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "r", arabic: "ه", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0))
        ],
        [
            Key(english: "s", arabic: "ـــ", color: UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0), action: .space),
            Key(english: "t", arabic: "ط", color: UIColor(red: 211/255, green: 151/255, blue: 211/255, alpha: 1.0)),
            Key(english: "u", arabic: "ك", color: UIColor(red: 200/255, green: 240/255, blue: 200/255, alpha: 1.0)),
            Key(english: "v", arabic: "ق", color: UIColor(red: 200/255, green: 240/255, blue: 200/255, alpha: 1.0)),
            Key(english: "w", arabic: "ع", color: UIColor(red: 230/255, green: 230/255, blue: 180/255, alpha: 1.0)),
            Key(english: "x", arabic: "↵", color: UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0), action: .enter)
        ]
    ]
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем кнопку переключения клавиатуры системную
        self.nextKeyboardButton = UIButton(type: .system)
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Создаем нашу клавиатуру
        setupHexagonalKeyboard()
    }
    
    func setupHexagonalKeyboard() {
        print("🟢 setupHexagonalKeyboard called")
        
        // Очищаем предыдущие кнопки
        keyboardButtons.forEach { row in
            row.forEach { $0.removeFromSuperview() }
        }
        keyboardButtons.removeAll()
        
        // Выбираем текущую раскладку
        let currentLayout = currentKeyboard == 1 ? keyboard1 : keyboard2
        
        // Создаем шестиугольные кнопки
        let screenWidth = UIScreen.main.bounds.width
        let padding: CGFloat = 6 // отступы по краям
        let numColumns: CGFloat = 6 // количество колонок
        
        // Рассчитываем оптимальный размер шестиугольника
        // Учитываем, что ширина шестиугольника = размер * cos(30°) * 2 ≈ размер * 1.732
        // И нужно учесть смещение рядов
        let availableWidth = screenWidth - (padding * 2)
        let hexWidth = availableWidth / (numColumns + 0.5) // +0.5 для смещения
        let hexSize = hexWidth / 0.866 // обратное от cos(30°)
        
        let horizontalSpacing: CGFloat = hexWidth
        let verticalSpacing: CGFloat = hexSize * 0.75 // для плотного расположения
        let startX: CGFloat = padding + hexSize * 0.433 // половина ширины шестиугольника
        let startY: CGFloat = 8
        
        for (rowIndex, row) in currentLayout.enumerated() {
            var rowButtons: [UIButton] = []
            
            // Смещение для нечетных рядов (сдвиг вправо)
            let rowOffset = rowIndex % 2 == 1 ? horizontalSpacing / 2 : 0
            
            for (colIndex, key) in row.enumerated() {
                let button = createHexagonButton(key: key, size: hexSize)
                
                let x = startX + rowOffset + CGFloat(colIndex) * horizontalSpacing
                let y = startY + CGFloat(rowIndex) * verticalSpacing + hexSize/2
                
                button.center = CGPoint(x: x, y: y)
                
                // Сохраняем данные о клавише
                button.tag = rowIndex * 10 + colIndex
                
                button.addTarget(self, action: #selector(keyButtonTapped(_:)), for: .touchUpInside)
                
                // Добавляем альтернативный обработчик для отладки
                button.addTarget(self, action: #selector(keyButtonTouchDown(_:)), for: .touchDown)
                
                self.view.addSubview(button)
                rowButtons.append(button)
            }
            
            keyboardButtons.append(rowButtons)
        }
    }
    
    func createHexagonButton(key: Key, size: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: size, height: size)
        
        // ВАЖНО: Делаем кнопку кликабельной
        button.isUserInteractionEnabled = true
        
        // Создаем фоновый view для шестиугольника
        let hexagonView = UIView(frame: button.bounds)
        hexagonView.isUserInteractionEnabled = false // Важно!
        
        // Создаем шестиугольную маску
        let hexPath = UIBezierPath()
        let center = CGPoint(x: size/2, y: size/2)
        let radius = size/2 - 1
        
        for i in 0..<6 {
            let angle = CGFloat(i) * CGFloat.pi / 3.0 - CGFloat.pi / 6.0
            let point = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
            
            if i == 0 {
                hexPath.move(to: point)
            } else {
                hexPath.addLine(to: point)
            }
        }
        hexPath.close()
        
        // Применяем маску к view, а не к кнопке
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = hexPath.cgPath
        shapeLayer.fillColor = key.color.cgColor
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.lineWidth = 0.5
        
        hexagonView.layer.addSublayer(shapeLayer)
        button.addSubview(hexagonView)
        
        // Текст кнопки
        let title: String
        if let action = key.action {
            switch action {
            case .delete: title = "⌫"
            case .switchKeyboard: title = key.arabic // "تشكيل"
            case .dot: title = "•"
            case .space: title = "ـــ"
            case .enter: title = "↵"
            }
        } else {
            title = key.arabic.isEmpty ? key.english : key.arabic
        }
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        // Размер шрифта в зависимости от контента и размера кнопки
        let fontSize = size / 2.5 // динамический размер шрифта
        if key.arabic == "تشكيل" {
            button.titleLabel?.font = .systemFont(ofSize: fontSize * 0.5, weight: .medium)
        } else if key.action != nil {
            button.titleLabel?.font = .systemFont(ofSize: fontSize * 0.85, weight: .regular)
        } else {
            button.titleLabel?.font = .systemFont(ofSize: fontSize, weight: .regular)
        }
        
        // Добавляем английскую букву в углу
        if !key.arabic.isEmpty && key.action == nil && key.arabic != "تشكيل" {
            let englishLabel = UILabel()
            englishLabel.text = key.english
            englishLabel.font = .systemFont(ofSize: fontSize * 0.4, weight: .light)
            englishLabel.textColor = UIColor.darkGray.withAlphaComponent(0.7)
            englishLabel.frame = CGRect(x: 0, y: size - fontSize * 0.8, width: size, height: fontSize * 0.6)
            englishLabel.textAlignment = .center
            englishLabel.isUserInteractionEnabled = false // Важно!
            button.addSubview(englishLabel)
        }
        
        return button
    }
    
    @objc func keyButtonTapped(_ sender: UIButton) {
        print("🔵 Button tapped! Tag: \(sender.tag)")
        
        let rowIndex = sender.tag / 10
        let colIndex = sender.tag % 10
        
        print("Row: \(rowIndex), Col: \(colIndex)")
        
        // Получаем текущую раскладку
        let currentLayout = currentKeyboard == 1 ? keyboard1 : keyboard2
        
        // Проверяем, что индексы в пределах массива
        guard rowIndex < currentLayout.count,
              colIndex < currentLayout[rowIndex].count else {
            print("❌ Index out of bounds")
            return
        }
        
        let key = currentLayout[rowIndex][colIndex]
        print("✅ Key found: \(key.english) - \(key.arabic)")
        
        // Анимация нажатия
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            sender.alpha = 0.6
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
                sender.alpha = 1.0
            }
        }
        
        // Обработка нажатий
        if let action = key.action {
            switch action {
            case .delete:
                print("Delete pressed")
                (textDocumentProxy as UIKeyInput).deleteBackward()
            case .switchKeyboard:
                print("Switch keyboard pressed")
                currentKeyboard = currentKeyboard == 1 ? 2 : 1
                setupHexagonalKeyboard()
            case .space:
                print("Space pressed")
                (textDocumentProxy as UIKeyInput).insertText(" ")
            case .enter:
                print("Enter pressed")
                (textDocumentProxy as UIKeyInput).insertText("\n")
            case .dot:
                print("Dot pressed")
                handleDotTransformation()
            }
        } else {
            // Вставляем текст
            let textToInsert = key.arabic.isEmpty ? key.english : key.arabic
            (textDocumentProxy as UIKeyInput).insertText(textToInsert)
            if let wholeText = textDocumentProxy.documentContextBeforeInput {
                let transformedText = mainTextTransformer.convert(wholeText)
                for _ in wholeText {
                    (textDocumentProxy as UIKeyInput).deleteBackward()
                }
                textDocumentProxy.insertText(transformedText)
            }
        }
    }

    // Преобразования для точки
    let dotTransformations: [String: String] = [
        // Hamza cycle
        String(UnicodeScalar(0x0621)!): String(UnicodeScalar(0x0623)!), // ء → أ
        String(UnicodeScalar(0x0623)!): String(UnicodeScalar(0x0625)!), // أ → إ
        String(UnicodeScalar(0x0625)!): String(UnicodeScalar(0x0626)!), // إ → ئ
        String(UnicodeScalar(0x0626)!): String(UnicodeScalar(0x0624)!), // ئ → ؤ
        String(UnicodeScalar(0x0624)!): String(UnicodeScalar(0x0623)!), // ؤ → أ

        // ح → خ → ج → ح
        String(UnicodeScalar(0x062D)!): String(UnicodeScalar(0x062E)!),
        String(UnicodeScalar(0x062E)!): String(UnicodeScalar(0x062C)!),
        String(UnicodeScalar(0x062C)!): String(UnicodeScalar(0x062D)!),

        // ب cycle
        String(UnicodeScalar(0x066E)!): String(UnicodeScalar(0x0628)!),
        String(UnicodeScalar(0x0628)!): String(UnicodeScalar(0x062A)!),
        String(UnicodeScalar(0x062A)!): String(UnicodeScalar(0x062B)!),
        String(UnicodeScalar(0x062B)!): String(UnicodeScalar(0x066E)!),

        // ه ↔ ة
        String(UnicodeScalar(0x0647)!): String(UnicodeScalar(0x0629)!),
        String(UnicodeScalar(0x0629)!): String(UnicodeScalar(0x0647)!),

        // ص ↔ ض
        String(UnicodeScalar(0x0635)!): String(UnicodeScalar(0x0636)!),
        String(UnicodeScalar(0x0636)!): String(UnicodeScalar(0x0635)!),

        // ع ↔ غ
        String(UnicodeScalar(0x0639)!): String(UnicodeScalar(0x063A)!),
        String(UnicodeScalar(0x063A)!): String(UnicodeScalar(0x0639)!),

        // ن → ت
        String(UnicodeScalar(0x0646)!): String(UnicodeScalar(0x062A)!),

        // No change group
        String(UnicodeScalar(0x064A)!): String(UnicodeScalar(0x064A)!),
        String(UnicodeScalar(0x0644)!): String(UnicodeScalar(0x0644)!),
        String(UnicodeScalar(0x0645)!): String(UnicodeScalar(0x0645)!),
        String(UnicodeScalar(0x0643)!): String(UnicodeScalar(0x0643)!),
        String(UnicodeScalar(0x0648)!): String(UnicodeScalar(0x0648)!),

        // ف ↔ ق
        String(UnicodeScalar(0x0641)!): String(UnicodeScalar(0x0642)!),
        String(UnicodeScalar(0x0642)!): String(UnicodeScalar(0x0641)!),

        // ا ↔ ى
        String(UnicodeScalar(0x0627)!): String(UnicodeScalar(0x0649)!),

        // ر ↔ ز
        String(UnicodeScalar(0x0631)!): String(UnicodeScalar(0x0632)!),
        String(UnicodeScalar(0x0632)!): String(UnicodeScalar(0x0631)!),

        // د ↔ ذ
        String(UnicodeScalar(0x062F)!): String(UnicodeScalar(0x0630)!),
        String(UnicodeScalar(0x0630)!): String(UnicodeScalar(0x062F)!),

        // ط ↔ ظ
        String(UnicodeScalar(0x0637)!): String(UnicodeScalar(0x0638)!),
        String(UnicodeScalar(0x0638)!): String(UnicodeScalar(0x0637)!),

        // س ↔ ش
        String(UnicodeScalar(0x0633)!): String(UnicodeScalar(0x0634)!),
        String(UnicodeScalar(0x0634)!): String(UnicodeScalar(0x0633)!),

        // Vowel transformations
        String(UnicodeScalar(0x064E)!): String(UnicodeScalar(0x064B)!),
        String(UnicodeScalar(0x064F)!): String(UnicodeScalar(0x064C)!),
        String(UnicodeScalar(0x0650)!): String(UnicodeScalar(0x064D)!)
    ]

    func handleDotTransformation() {
        // Получаем последний введенный символ
        if let context = textDocumentProxy.documentContextBeforeInput,
           let lastChar = context.last {
            let lastCharStr = String(lastChar)
            
            if let replacement = dotTransformations[lastCharStr] {
                textDocumentProxy.deleteBackward()
                textDocumentProxy.insertText(replacement)
            } else {
                textDocumentProxy.insertText(".")
            }
        } else {
            textDocumentProxy.insertText(".")
        }
    }
    
    @objc func keyButtonTouchDown(_ sender: UIButton) {
        print("🟡 Touch DOWN detected! Tag: \(sender.tag)")
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton?.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {}
    
    override func textDidChange(_ textInput: UITextInput?) {
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton?.setTitleColor(textColor, for: [])
    }
}
