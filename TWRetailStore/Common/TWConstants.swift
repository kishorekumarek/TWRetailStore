//
//  TWConstants.swift
//  TWRetailStore
//
//  Created by Kishore on 09/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import Foundation

typealias ProductConstants = DataConstants.ProductProperties
typealias CategoryConstants = DataConstants.CategoryProperties

struct TWConstants {

}
struct DBConstants {
    static let productMO = "Product"
    static let categoryMO = "Category"
    static let customerMo = "Customer"
}

struct DataConstants {
    struct CategoryProperties {
        static let categoryID = "catId"
        static let categoryName = "catName"
    }

    struct ProductProperties {
        static let price = "price"
        static let productDescription = "description"
        static let productID = "productId"
        static let productName = "name"
        static let productImage = "image"
        static let categoryID = "catId"
    }
}
