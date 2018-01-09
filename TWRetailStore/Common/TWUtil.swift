//
//  TWUtil.swift
//  TWRetailStore
//
//  Created by Kishore on 10/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showSimpleAlert(message: String) {
        let alert = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}
