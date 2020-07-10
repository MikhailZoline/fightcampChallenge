//
//  PackageCellViewModel.swift
//  FightCamp-Homework
//
//  Created by Mikhail Zoline on 7/8/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

class PackageCellViewModel {
    //Package Cell fileds
    var thumbnailStack: [UIImage?]
    var title: NSAttributedString?
    var desc: NSAttributedString?
    var packageItems: [NSAttributedString]
    var payment: NSAttributedString?
    var price: NSAttributedString?
    var action: NSAttributedString?
    
    // serialize an instance of Package Model into Package Cell Fileds
    init(with package: PackageModel) {
        thumbnailStack = Array.init(repeating: UIImage(named: "placeholder.png"), count: 4)
        packageItems = []
        
        let group = DispatchGroup()
        for index in  0 ..< 4 {
            if let imageURL = URL(string: package.thumbnail_urls[index]) {
                group.enter()
                DispatchQueue.global(qos: .userInitiated).async {
                    if let data = try? Data(contentsOf: imageURL){
                        DispatchQueue.main.async {
                            unowned let unownedSelf = self
                            unownedSelf.thumbnailStack[index] = (UIImage(data: data)!)
                            group.leave()
                        }
                    }
                }
            }
        }
        group.notify(queue: DispatchQueue.main) {
            NotificationCenter.default.post(name: .reloadFirstRowName, object: nil)
        }
        
        title = NSAttributedString(string:package.title.uppercased(), attributes: [.font : UIFont.title, .foregroundColor : UIColor.brandRed])
        
        
        desc = NSAttributedString(string:package.desc.capitalized, attributes: [.font : UIFont.body, .foregroundColor : UIColor.label])
        
        var includedItemsString = ""
        var excludedItemsString = ""
        if let excluded = package.excluded {
            includedItemsString = package.included.joined(separator: "\n") + "\n"
            let start = includedItemsString.count
            excludedItemsString = excluded.joined(separator: "\n")
            let length = excludedItemsString.count
            
            includedItemsString += excludedItemsString
            
            let includedAttributeString: NSMutableAttributedString =
                NSMutableAttributedString(string:includedItemsString.capitalized,
                                          attributes: [.font : UIFont.body, .foregroundColor : UIColor.label] )
            
            includedAttributeString.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: start, length: length ))
            packageItems.append(includedAttributeString)
            
        } else {
            includedItemsString = package.included.joined(separator: "\n")
            let includedAttributeString: NSMutableAttributedString =
                NSMutableAttributedString(string:includedItemsString.capitalized,
                                          attributes: [.font : UIFont.body, .foregroundColor : UIColor.label] )
            packageItems.append(includedAttributeString)
        }
        
        payment =  NSAttributedString(string:package.payment.capitalized, attributes: [.font : UIFont.body, .foregroundColor : UIColor.label])
        var dollarSign = "$"
        let priceString = String(package.price)
        dollarSign.append(priceString)
        price = NSAttributedString(string: dollarSign, attributes: [.font : UIFont.price, .foregroundColor : UIColor.label])
        action = NSAttributedString(string: package.action.capitalized, attributes: [.font : UIFont.body, .foregroundColor : UIColor.buttonTitle])
    }
}

