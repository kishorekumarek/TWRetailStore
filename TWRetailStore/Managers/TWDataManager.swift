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
            let jsonPath = Bundle.main.path(forResource: "products", ofType: "json")
            let url = URL(fileURLWithPath: jsonPath!)
            let data = try Data(contentsOf: url, options: .mappedRead)
            let jsonDict = try JSONSerialization.jsonObject(with: data, options: nil)
        }
    }
}
