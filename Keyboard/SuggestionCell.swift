import UIKit

class SuggestionCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor

        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
