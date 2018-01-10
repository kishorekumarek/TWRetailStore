//
//  ProductListCollectionViewCell.swift
//  TWRetailStore
//
//  Created by Kishore on 06/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var productImageView: UIImageView?
    @IBOutlet private weak var productNameLabel: UILabel?
    @IBOutlet private weak var priceLabel: UILabel?
    @IBOutlet private weak var bgView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView?.layer.borderColor = UIColor.lightGray.cgColor
        bgView?.layer.borderWidth = 1.0
        // Initialization code
    }

    func configure(product: Product?) {
        productImageView?.image = UIImage(named: product?.image ?? "")
        productNameLabel?.text = product?.productName
        priceLabel?.text = "Rs.\(product?.price ?? "0")"
    }
}
