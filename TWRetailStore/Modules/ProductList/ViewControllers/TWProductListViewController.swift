//
//  TWProductListViewController.swift
//  TWRetailStore
//
//  Created by Kishore on 06/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import UIKit

class TWProductListViewController: UIViewController {
    let ProductListCellIdentifier = "ProductListCell"
    @IBOutlet weak var productListCollectionView: UICollectionView?
    var viewModel: TWProductListViewModel = TWProductListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCollectionViewData()
        let cellNib = UINib.init(nibName: String(describing: ProductListCollectionViewCell.self), bundle: nil)
        productListCollectionView?.register(cellNib, forCellWithReuseIdentifier: ProductListCellIdentifier)
        // Do any additional setup after loading the view.
    }

    func loadCollectionViewData() {
        DispatchQueue.main.async {
            self.viewModel.loadProductData(onSuccess: { [weak self] in
                self?.productListCollectionView?.reloadData()
            }, onError: { [weak self] (error) in
                    self?.showSimpleAlert(message: error)
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TWProductListViewController: UICollectionViewDelegate {

}

extension TWProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCellIdentifier, for: indexPath)
        let category = viewModel.categories?[indexPath.section]
        category.map({
            let productsArray = viewModel.productsDict?[$0]
            let product = productsArray?[indexPath.row]
            if let productCell = cell as? ProductListCollectionViewCell {
                productCell.configure(product: product)
            }
        })
        return cell
    }
}
