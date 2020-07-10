//
//  PackageViewController.swift
//  FightCamp-Homework
//
//  Created by Mikhail Zoline on 7/8/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let reloadFirstRowName = Notification.Name("completedFirstDownload")
}

class PackageViewController: UIViewController, UICollectionViewDelegate {
    
    var collectionDataSource: PackageCollectionDataSource = { PackageCollectionDataSource() }()
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFirstRow), name: .reloadFirstRowName, object: nil)
        setupViews()
        setupLayouts()
        collectionView.reloadData()
    }
    
    @objc func reloadFirstRow()  {
        DispatchQueue.main.async {
            unowned let unownedSelf  = self
            unownedSelf.collectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        }
    }
    
    private func setupViews() {
        
        view.backgroundColor = UIColor.secondaryBackground
        view.addSubview(collectionView)

        collectionView.dataSource = collectionDataSource
        collectionView.delegate = self
        collectionView.register(PackageCell.self, forCellWithReuseIdentifier: PackageCell.identifier)
        collectionView.backgroundColor = UIColor.secondaryBackground
    }
    
    private func setupLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PackageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: view.frame.width, spacing: .packageSpacing)
        let height = itemHeight(for: view.frame.height, spacing: .packageSpacing)
        return CGSize(width: width, height: height)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = 2 * spacing
        let finalWidth = (width - totalSpacing)

        return floor(finalWidth)
    }

    func itemHeight(for height: CGFloat, spacing: CGFloat) -> CGFloat {
        print(height)
        let totalSpacing: CGFloat = 2 * spacing
        let finalHeigth = height < 670 ?
            height + totalSpacing * 2 : height < 740 ?
                height + totalSpacing : height < 820 ?
                    height - totalSpacing : height - totalSpacing * 2
        return floor(finalHeigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .packageSpacing, left: .packageSpacing, bottom: .packageSpacing, right: .packageSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .packageSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .packageSpacing
    }
}
