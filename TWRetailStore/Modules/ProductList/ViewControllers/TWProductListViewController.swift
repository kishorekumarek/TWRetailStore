//
//  TWProductListViewController.swift
//  TWRetailStore
//
//  Created by Kishore on 06/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import UIKit

class TWProductListViewController: UIViewController {
    @IBOutlet weak var productListCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib.init(nibName: String(describing: ProductListCollectionViewCell.self), bundle: nil)
        productListCollectionView?.register(cellNib, forCellWithReuseIdentifier: "ProductListCell")
        // Do any additional setup after loading the view.
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
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath)
        return cell
    }
}
