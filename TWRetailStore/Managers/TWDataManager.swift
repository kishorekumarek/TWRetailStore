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
                // appropriate error handling
                return
            }
            print("jsonDict: \(jsonDict)")
            print("name: \(String(describing: jsonDict["categories"]))")
            // Convert json to domain objects, use if needed
            /* do {
             let data = try Data(contentsOf: file)
             let decoder = JSONDecoder()
             let product = try decoder.decode([ProductModel].self, from: data)
             // onSucess(product)
             print(product)
             } catch {
             print("Error Parsing")
             } */

        } catch {

        }
    }
}
