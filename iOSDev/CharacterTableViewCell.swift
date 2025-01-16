//
//  CharacterTableViewCell.swift
//  iOSDev
//
//  Created by KAMA . on 16.01.2025.
//

import UIKit
import SDWebImage

final class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterTableViewCell"

    // MARK: - Subviews
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 1
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var watchEpisodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶ Watch Episode", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.systemOrange, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = CGColor(red: 255/255, green: 107/255, blue: 0/255, alpha: 0.1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusBackgroundView)
        statusBackgroundView.addSubview(statusLabel)
        contentView.addSubview(genderLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(watchEpisodeButton)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Character image view
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterImageView.widthAnchor.constraint(equalToConstant: 120),
            characterImageView.heightAnchor.constraint(equalToConstant: 120),

            // Name label
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 30),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusBackgroundView.leadingAnchor, constant: -8),

            // Status background view
            statusBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            statusBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            statusBackgroundView.heightAnchor.constraint(equalToConstant: 28),
            statusBackgroundView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),

            // Status label
            statusLabel.topAnchor.constraint(equalTo: statusBackgroundView.topAnchor, constant: 4),
            statusLabel.bottomAnchor.constraint(equalTo: statusBackgroundView.bottomAnchor, constant: -4),
            statusLabel.leadingAnchor.constraint(equalTo: statusBackgroundView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: statusBackgroundView.trailingAnchor, constant: -8),

            // Gender label
            genderLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 30),
            genderLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0),
            genderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Watch Episode button
            watchEpisodeButton.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 30),
            watchEpisodeButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            watchEpisodeButton.widthAnchor.constraint(equalToConstant: 150),
            watchEpisodeButton.heightAnchor.constraint(equalToConstant: 35),

            // Location label
            locationLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 30),
            locationLabel.topAnchor.constraint(equalTo: watchEpisodeButton.bottomAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Configuration
    func configure(with character: Character) {
        nameLabel.text = character.name
         genderLabel.text = "\(character.species), \(character.gender)"
         
         // Создаем атрибутированный текст для locationLabel
         let locationText = NSMutableAttributedString()
         
         if let locationIcon = UIImage(named: "locationIcon") { // Убедитесь, что добавили изображение в проект
             let attachment = NSTextAttachment()
             attachment.image = locationIcon
             attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12) // Настройка размера и позиции
             let imageString = NSAttributedString(attachment: attachment)
             locationText.append(imageString)
         }
         
         let locationName = NSAttributedString(string: " \(character.location.name)")
         locationText.append(locationName)
         
         locationLabel.attributedText = locationText

        // Set status label and background color
        statusLabel.text = character.status.uppercased()
        switch character.status {
        case "Alive":
            statusBackgroundView.backgroundColor = UIColor(red: 199/255, green: 255/255, blue: 185/255, alpha: 1)
            statusLabel.textColor = UIColor(red: 49/255, green: 159/255, blue: 22/255, alpha: 1)
        case "Dead":
            statusBackgroundView.backgroundColor = UIColor(red: 255/255, green: 232/255, blue: 224/255, alpha: 1)
            statusLabel.textColor = UIColor(red: 233/255, green: 56/255, blue: 0/255, alpha: 1)
        default:
            statusBackgroundView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
            statusLabel.textColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1)        }

        // Set image using SDWebImage
        if let imageUrl = URL(string: character.image) {
            characterImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(systemName: "photo"))
        } else {
            characterImageView.image = UIImage(systemName: "photo")
        }
    }
}

import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CharactersViewController {
        return CharactersViewController()
    }
    
    func updateUIViewController(_ uiViewController: CharactersViewController, context: Context) {
    }
}

// PreviewProvider для SwiftUI
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
        //            .previewLayout(.sizeThatFits)
    }
}
