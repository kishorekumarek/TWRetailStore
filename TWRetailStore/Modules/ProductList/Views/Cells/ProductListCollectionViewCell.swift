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
    @IBOutlet private weak var productDescLabel: UILabel?
    @IBOutlet private weak var priceLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(product: Product?) {
        productImageView?.image = UIImage(named: product?.image ?? "")
        productNameLabel?.text = product?.productName
        priceLabel?.text = "Rs.\(product?.price ?? "0")"
    }
}
