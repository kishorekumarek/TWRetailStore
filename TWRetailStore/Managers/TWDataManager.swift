//
//  TWDataManager.swift
//  TWRetailStore
//
//  Created by Kishore on 09/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import Foundation

class TWDataManager {
    class func loadProductData(onSucess: ([Product]) -> Void, onError: (String) -> Void) {
        do {
            guard let file = Bundle.main.url(forResource: "products", withExtension: "json") else {
                return
            }
            let data = try Data(contentsOf: file)
            guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                onError("error in json parsing")
                return
            }
            let _ = (jsonDict["categories"] as? [[String: String]]).map(updateCategoriessInDb(catArray:))

            if let products = jsonDict["products"] as? [[String: String]] {
                onSucess(updateProductsInDb(productsArray: products))
            } else {
                onError("error in json parsing")
            }
        } catch {

        }
    }
    private class func updateCategoriessInDb(catArray: [[String: String]]) -> [Category] {
        var categories: [Category] = []
        for category in catArray {
            let categoryMO = TWDBManager.sharedManager.addOrUpdateCategory(category: category)
            categoryMO.map({categories.append($0)})
        }
        return categories
    }

    private class func updateProductsInDb(productsArray: [[String: String]]) -> [Product] {
        var products: [Product] = []
        for product in productsArray {
            let productMo = TWDBManager.sharedManager.addOrUpdateProduct(product: product)
            productMo.map({products.append($0)})
        }
        TWDBManager.sharedManager.saveContext()
        return products
    }
}
