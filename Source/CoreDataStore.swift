//
//  CoreDataStore.swift
//  RGCacheKit
//
//  Created by Ritesh Gupta on 02/01/18.
//  Copyright © 2018 Ritesh Gupta. All rights reserved.
//

import Foundation
import CoreData

public final class CoreDataStore {
	
	let modelName: String
	
	public init(modelName: String) { self.modelName = modelName }
	
	public lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: modelName)
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? { fatalError("Unresolved error \(error), \(error.userInfo)") }
		})
		return container
	}()
	
	public var mainContext: NSManagedObjectContext { return persistentContainer.viewContext }
	
	public func newPrivateContext() -> NSManagedObjectContext { return persistentContainer.newBackgroundContext() }
	
	public func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Swift.Void) {
		persistentContainer.performBackgroundTask(block)
	}
}
