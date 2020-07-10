//
//  Fonts.swift
//  FightCamp-Homework
//
//  Created by Alexandre Marcotte on 6/17/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

// MARK: - Font

extension UIFont {

    /// Package title label font
    public static var title: UIFont = UIFont(
        name: .groteskSquare,
        size: 36)!

    /// Package description label & package accessories label & price title label
    public static var body: UIFont = UIFont(
        name: .graphikMedium,
        size: 16)!

    /// Price label font
    public static var price: UIFont = UIFont(
        name: .graphikMedium,
        size: 26)!

    /// CTA button font
    public static var button: UIFont = UIFont(
        name: .graphikMedium,
        size: 16)!
}

// MARK: - Font names

extension String {

    fileprivate static let graphikMedium: String = "Graphik-Medium"
    fileprivate static let graphikRegular: String = "Graphik-Regular"
    fileprivate static let groteskSquare: String = "NewGroteskSquareFOUR"
}
