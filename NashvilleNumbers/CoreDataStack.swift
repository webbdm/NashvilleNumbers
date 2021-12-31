//
//  CoreDataStack.swift
//  NashvilleNumbers
//
//  Created by Geoff Webb on 12/30/21.
//  Copyright © 2021 Geoff Webb. All rights reserved.
//

import Foundation
import CoreData

func createMainContext()-> NSManagedObjectContext {
    let modelURL = Bundle.main.url(forResource: "Song", withExtension: "momd")
    guard let model = NSManagedObjectModel(contentsOf: modelURL!) else {fatalError("model not found")}
    
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    let storeURL = URL.documentsURL.appendingPathComponent("Song.sqlite")
    try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)

    let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    return context;
}

extension URL {
    static var documentsURL: URL {
        return try! FileManager
                    .default
                    .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}
