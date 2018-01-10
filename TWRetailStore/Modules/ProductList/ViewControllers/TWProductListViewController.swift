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
    let ProductListHeaderIdentifier = "ProductListHeader"

    @IBOutlet weak var productListCollectionView: UICollectionView?
    var viewModel: TWProductListViewModel = TWProductListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCollectionViewData()

        let cellNib = UINib.init(nibName: String(describing: ProductListCollectionViewCell.self), bundle: nil)
        productListCollectionView?.register(cellNib, forCellWithReuseIdentifier: ProductListCellIdentifier)
        let headerNib = UINib.init(nibName: String(describing: TWProductlistSectionHeaderView.self), bundle: nil)
        productListCollectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProductListHeaderIdentifier)

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

extension TWProductListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.categories?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = viewModel.categories?[section]
        guard let cat = category, let prodArray = viewModel.productsDict?[cat] else {
            return 0
        }
        return prodArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40.0)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProductListHeaderIdentifier, for: indexPath)
            if let productListHeader = header as? TWProductlistSectionHeaderView,
                let category = viewModel.categories?[indexPath.section] {
                productListHeader.titleLabel.text = category.categoryName
            }
            return header
        } else {
            let footer =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "Footer", for: indexPath)
            return footer
        }
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
