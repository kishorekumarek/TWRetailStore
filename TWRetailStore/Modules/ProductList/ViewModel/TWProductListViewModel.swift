//
//  TWProductListViewModel.swift
//  TWRetailStore
//
//  Created by Kishore on 06/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import Foundation

class TWProductListViewModel {
    var products: [Product]?
    func loadProductData(onSuccess: () -> Void, onError: (String) -> Void) {

        TWDataManager.loadProductData(onSucess: { [weak self] (products) in
            self?.products = products
            onSuccess()
        }) {(errorMessage) in
            onError(errorMessage)
        }
        
    }

}
