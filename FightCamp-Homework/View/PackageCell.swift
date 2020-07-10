//
//  PackageViewCell.swift
//  FightCamp-Homework
//
//  Created by Mikhail Zoline on 7/8/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

protocol ReusableCell: AnyObject {
    static var identifier: String { get }
}

extension PackageCell: ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIStackView {
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
}

class PackageTextView: UITextView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

final class PackageCell: UICollectionViewCell {    
    // Title label
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    //Subtitle label
    private let descLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    //Thumbnail Image View
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = .thumbnailRadius
        return imageView
    }()
    //Thumbnail Image Stack
    private let thumbnailStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = .thumbnailSpacing
        return stackView
    }()
    
    //Thumbnail Image Button View
    private let thumbnailButtonArray: [UIButton] = {
        var array = [UIButton]()
        for index in 0 ... 3 {
            let button = UIButton(frame: .zero)
            button.layer.cornerRadius = .thumbnailRadius
            button.layer.borderWidth = .thumbnailSpacing
            button.tag = index
            button.layer.borderColor = UIColor.thumbnailBorder(selected: false).cgColor
            array.append(button)
        }
        return array
    }()
    
    static var currentThumbnailIndex = 0
    
    @objc func thumbnailButtonClicked(button: UIButton!)  {
        if PackageCell.currentThumbnailIndex != button.tag {
            PackageCell.currentThumbnailIndex = button.tag
            NotificationCenter.default.post(name: .reloadFirstRowName, object: nil)
        }
    }
    //Package Items Text View
    private let packageItemsTextView: PackageTextView = {
        let textView = PackageTextView(frame: .zero)
        textView.textAlignment = NSTextAlignment.right
        textView.backgroundColor = .primaryBackground
        textView.isEditable = false
        textView.isScrollEnabled = false        
        return textView
    }()
    //Payment label
    private let paymentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    //Price label
    private let priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    //Action Button View
    private let actionlButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = .thumbnailRadius
        button.layer.backgroundColor = UIColor.buttonBackground.cgColor
        button.isEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = .packageRadius
        contentView.backgroundColor = UIColor.primaryBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(thumbnailStackView)
        contentView.addSubview(packageItemsTextView)
        contentView.addSubview(paymentLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(actionlButton)
    }
    
    private func setupLayouts() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailStackView.translatesAutoresizingMaskIntoConstraints = false
        packageItemsTextView.translatesAutoresizingMaskIntoConstraints = false
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        actionlButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout constraints for `titleLabel`
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .packageSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.packageSpacing),
            titleLabel.topAnchor.constraint( greaterThanOrEqualTo: contentView.topAnchor, constant: .packageSpacing )
        ])
        
        // Layout constraints for `descriptionLabel`
        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .packageSpacing),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.packageSpacing),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .packageSpacing - .thumbnailSpacing/2 )
        ])
        
        // Layout constraints for `thumbnailImageView`
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .packageSpacing),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.packageSpacing),
            thumbnailImageView.topAnchor.constraint(greaterThanOrEqualTo: descLabel.bottomAnchor, constant: .packageSpacing - .thumbnailSpacing),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: .thumbnailHeight)
        ])
        
        // Layout constraints for `thumbnailStackView`
        NSLayoutConstraint.activate([
            thumbnailStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            thumbnailStackView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: .thumbnailSpacing),
        ])
        
        // Layout constraints for `packageItemsTextView`
        NSLayoutConstraint.activate([
            packageItemsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .packageSpacing),
            packageItemsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.packageSpacing),
            packageItemsTextView.topAnchor.constraint(greaterThanOrEqualTo: thumbnailStackView.bottomAnchor, constant: .packageSpacing / 2 + .thumbnailSpacing),
            packageItemsTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: .thumbnailHeight - .packageSpacing * 4)

        ])
        
        // Layout constraints for `paymentLabel`
        NSLayoutConstraint.activate([
            paymentLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            paymentLabel.topAnchor.constraint(greaterThanOrEqualTo: packageItemsTextView.bottomAnchor, constant: .packageSpacing / 3),
        ])
        
        // Layout constraints for `priceLabel`
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            priceLabel.topAnchor.constraint(greaterThanOrEqualTo:  paymentLabel.bottomAnchor, constant:.thumbnailSpacing/2),
        ])
        
        // Layout constraints for `action Button`
        NSLayoutConstraint.activate([
            actionlButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .packageSpacing),
            actionlButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.packageSpacing),
            actionlButton.topAnchor.constraint(lessThanOrEqualTo: priceLabel.bottomAnchor, constant: .packageSpacing),
            actionlButton.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: -.packageSpacing),
            actionlButton.heightAnchor.constraint(equalToConstant:.buttonHeight)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with packageModel: PackageCellViewModel) {
        thumbnailImageView.image = packageModel.thumbnailStack[PackageCell.currentThumbnailIndex]
        
        titleLabel.attributedText = packageModel.title
        descLabel.attributedText = packageModel.desc
        packageItemsTextView.attributedText = packageModel.packageItems[0]
        paymentLabel.attributedText = packageModel.payment
        priceLabel.attributedText = packageModel.price
        actionlButton.setAttributedTitle(packageModel.action, for: .disabled)
        
        setUpThumbnails(thumbnails: packageModel.thumbnailStack)
    }
    
    func setUpThumbnails(thumbnails: [UIImage?]) {
        thumbnailStackView.removeFullyAllArrangedSubviews()
        let size = thumbnailSize(for: self.contentView.bounds.width - .thumbnailSpacing * 2, spacing: .thumbnailSpacing)
        
        for (index,button) in thumbnailButtonArray.enumerated() {
            let image = thumbnails[index]
            button.addTarget(self, action: #selector(thumbnailButtonClicked(button:)), for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: size).isActive = true
            button.widthAnchor.constraint(equalToConstant: size).isActive = true
            button.setImage(image, for: .normal)
            button.imageView?.layer.cornerRadius = .thumbnailRadius
            button.imageView?.clipsToBounds = true
            button.layer.borderColor = UIColor.thumbnailBorder(selected: index == PackageCell.currentThumbnailIndex ? true : false).cgColor
            thumbnailStackView.addArrangedSubview(button)
        }
    }
    
    func thumbnailSize(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = 3 * spacing
        let finalWidth = (width / 4 - totalSpacing)
        return floor(finalWidth)
    }
    
}
