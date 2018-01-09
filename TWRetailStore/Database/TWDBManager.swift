//
//  TWDBManager.swift
//  TWRetailStore
//
//  Created by Kishore on 03/01/18.
//  Copyright © 2018 Kishore. All rights reserved.
//

import Foundation
import CoreData

enum ContextType {
    case mainContext
    case privateContext
}

class TWDBManager {
    static var sharedManager = TWDBManager()
    // MARK: - Core Data stack

    func getMoc(type: ContextType) -> NSManagedObjectContext {
        switch type {
        case .mainContext:
            return mainContext
        default:
            return privateContext
        }
    }

    private lazy var mainContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

    private lazy var privateContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TWRetailStore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getNewManagedObject(name: String,
                             moc: NSManagedObjectContext) -> NSManagedObject {
        let mo = NSEntityDescription.insertNewObject(forEntityName: name, into: moc)
        return mo
    }

    func getProduct(productId: String,
                    moc: NSManagedObjectContext) -> Product? {
        var fetchedProduct: Product?
        let fetchRequest = NSFetchRequest<Product>(entityName: String(describing: Product.self))
        let predicate = NSPredicate(format: "productId = %@", productId)
        fetchRequest.predicate = predicate
        do {
            let result = try moc.fetch(fetchRequest)
            if result.isEmpty == false {
                fetchedProduct = result.first
            }
        } catch {
            print("fetch error")
        }
        return fetchedProduct
    }

    func getCategory(categoryId: String,
                     moc: NSManagedObjectContext) -> Category? {
        var fetchedCategory: Category?
        let fetchRequest = NSFetchRequest<Category>(entityName: String(describing: Category.self))
        let predicate = NSPredicate(format: "categoryId = %@", categoryId)
        fetchRequest.predicate = predicate
        do {
            let result = try moc.fetch(fetchRequest)
            if result.isEmpty == false {
                fetchedCategory = result.first
            }
        } catch {
            print("fetch error")
        }
        return fetchedCategory
    }

    func addOrUpdateProduct(product: [String: String]) -> Product? {
        guard let productId = product[ProductConstants.productID] else {
            return nil
        }

        let moc = TWDBManager.sharedManager.getMoc(type: .mainContext)
        var productMO = TWDBManager.sharedManager.getProduct(productId: productId,
                                                             moc: moc)
        if productMO == nil {
            productMO = TWDBManager.sharedManager.getNewManagedObject(name: DBConstants.productMO, moc: moc) as? Product
        }
        productMO?.productId = product[ProductConstants.productID]
        productMO?.price = product[ProductConstants.price]
        productMO?.productDescription = product[ProductConstants.productDescription]
        productMO?.productName = product[ProductConstants.productName]
        productMO?.image = product[ProductConstants.productImage]
        product[ProductConstants.categoryID].map({
            var category = getCategory(categoryId: $0, moc: moc)
            if category == nil {
                category = getNewManagedObject(name: DBConstants.categoryMO, moc: moc) as? Category
                category?.categoryId = $0
            }
            productMO?.category = category
        })
        return productMO
    }

    func addOrUpdateCategory(category: [String: String]) -> Category? {
        guard let catId = category[CategoryConstants.categoryID] else {
            return nil
        }

        let moc = TWDBManager.sharedManager.getMoc(type: .mainContext)
        var catMO = TWDBManager.sharedManager.getCategory(categoryId: catId, moc: moc)
        if catMO == nil {
            catMO = TWDBManager.sharedManager.getNewManagedObject(name: DBConstants.categoryMO, moc: moc) as? Category
        }
        catMO?.categoryName = category[CategoryConstants.categoryName]
        return catMO
    }
}
