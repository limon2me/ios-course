//
//  CourseCardView.swift
//  ios-cource
//
//  Created by v.khabarov on 18.05.2024.
//

import UIKit

final class CourseCardView: UIView {

    struct ViewModel {
        let cover: UIImage
        let title: String
        let subtitle: String
        let actionButtonTitle: String
        let actionButtonHandler: (() -> Void)?
        let favouriteButtonHandler: (() -> Void)?
    }

    var actionButtonHandler: (() -> Void)?
    var favouriteButtonHandler: (() -> Void)?

    // MARK: - Private properties

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()

    private let courseInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        return stackView
    }()

    private let textsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        return stackView
    }()

    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = FontBuilder.sfProRoundedFont(24.0)
        label.textColor = .white
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = FontBuilder.sfProRoundedFont(16.0)
        label.textColor = UIColor(white: 1.0, alpha: 0.6)
        return label
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24.0
        view.backgroundColor = UIColor(red: 0.67, green: 0.56, blue: 0.78, alpha: 1.00)
        return view
    }()

    private lazy var actionButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributeContainer in
            var newAttributeContainer = attributeContainer
            newAttributeContainer.font = FontBuilder.sfProRoundedFont(20.0)
            return newAttributeContainer
        }
        let button = UIButton(
            configuration: configuration,
            primaryAction: UIAction { _ in self.actionButtonHandler?() })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var favouriteButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "heart.fill")?
            .withTintColor(
                UIColor(red: 0.92, green: 0.29, blue: 0.40, alpha: 1.00),
                renderingMode: .alwaysOriginal
            )
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20.0)
        let button = UIButton(
            configuration: configuration,
            primaryAction: UIAction { _ in self.favouriteButtonHandler?() })
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        return button
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        actionButton.layer.insertSublayer(
            gradientLayer(actionButton.bounds),
            at: 0
        )
        favouriteButton.layer.insertSublayer(
            gradientLayer(favouriteButton.bounds),
            at: 0
        )
    }

    func configure(from viewModel: ViewModel) {
        coverImageView.image = viewModel.cover
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        actionButtonHandler = viewModel.actionButtonHandler
        favouriteButtonHandler = viewModel.favouriteButtonHandler
    }

    // MARK: - Private methods

    private func configureLayout() {
        textsStackView.addArrangedSubview(titleLabel)
        textsStackView.addArrangedSubview(subtitleLabel)

        courseInfoStackView.addArrangedSubview(coverImageView)
        courseInfoStackView.addArrangedSubview(textsStackView)

        buttonsStackView.addArrangedSubview(actionButton)
        buttonsStackView.addArrangedSubview(favouriteButton)

        contentStackView.addArrangedSubview(courseInfoStackView)
        contentStackView.addArrangedSubview(buttonsStackView)

        addSubview(contentView)
        contentView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            contentStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),

            coverImageView.widthAnchor.constraint(equalToConstant: 170.0),

            favouriteButton.widthAnchor.constraint(equalToConstant: 56.0),
            favouriteButton.heightAnchor.constraint(equalToConstant: 56.0),
        ])
    }

    private func gradientLayer(_ frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1).cgColor,
            UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2).cgColor,
        ]
        gradientLayer.frame = frame
        return gradientLayer
    }
}
