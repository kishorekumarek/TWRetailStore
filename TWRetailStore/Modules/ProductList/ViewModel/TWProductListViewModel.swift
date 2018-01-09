//
//  TWProductListViewModel.swift
//  TWRetailStore
//
//  Created by Kishore on 06/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import Foundation

class TWProductListViewModel {
    var categories: [Category]?
    var productsDict: [Category: [Product]]?
    func loadProductData(onSuccess: () -> Void, onError: (String) -> Void) {
        TWDataManager.loadProductData(onSucess: { [weak self] (categories) in
            self?.categories = categories
            onSuccess()
        }) {(errorMessage) in
            onError(errorMessage)
        }
    }

    private func updateProductsDict() {
        guard let cats = categories else {
            return
        }
        productsDict = [:]
        for category in cats {
            productsDict?[category] = category.products?.allObjects as? [Product]
        }
    }

}
