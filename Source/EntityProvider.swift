//
//  EntityProvider.swift
//  RGCacheKit
//
//  Created by Ritesh Gupta on 03/01/18.
//  Copyright © 2018 Ritesh Gupta. All rights reserved.
//

import Foundation
import CoreData

public protocol EntityProvider: class {
	
	static func newObject<T: EntityFetchInfoProvider>(context: EntityContext) -> T
	
	static func object<T: EntityFetchInfoProvider>(for objectID: String, context: EntityContext) -> T
	
	static func existingObject<T: EntityFetchInfoProvider>(for objectID: String, context: EntityContext) -> T?
	
	static func allObjects<T: EntityFetchInfoProvider>(context: EntityContext) -> [T]
	
	static func objects<T: EntityFetchInfoProvider>(
		key: String,
		for value: Any,
		sortKey: String?,
		isSortOrderAscending: Bool,
		comparisonType: PredicateComparisonType,
		fetchLimit: Int,
		context: EntityContext) -> [T]
	
	static func objects<T: EntityFetchInfoProvider>(
		predicate: NSPredicate?,
		sortDescriptors: [NSSortDescriptor]?,
		fetchLimit: Int,
		context: EntityContext) -> [T]
}
