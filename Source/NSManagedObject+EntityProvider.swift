//
//  NSManagedObject+EntityProvider.swift
//  RGCacheKit
//
//  Created by Ritesh Gupta on 02/01/18.
//  Copyright © 2018 Ritesh Gupta. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject: EntityProvider {
	
	public class func newObject<T: EntityFetchInfoProvider>(context: EntityContext) -> T {
		return NSEntityDescription.insertNewObject(
			forEntityName: T.entityName,
			into: context as! NSManagedObjectContext) as! T
	}
	
	public class func object<T: EntityFetchInfoProvider>(for objectID: String, context: EntityContext) -> T {
		if let object: T = existingObject(for: objectID, context: context) {
			return object
		} else {
			return newObject(context: context)
		}
	}
	
	public class func existingObject<T: EntityFetchInfoProvider>(for objectID: String, context: EntityContext) -> T? {
		return objects(for: objectID, fetchLimit: 1, context: context).first
	}
	
	public class func allObjects<T: EntityFetchInfoProvider>(context: EntityContext) -> [T] {
		let sortDescriptors: [NSSortDescriptor]?
		if let sortKey = T.defaultSortingKey { sortDescriptors = [NSSortDescriptor(key: sortKey, ascending: T.isSortOrderAscending)] }
		else { sortDescriptors = nil }
		return objects(sortDescriptors: sortDescriptors, fetchLimit: Int.max, context: context)
	}
	
	public class func objects<T: EntityFetchInfoProvider>(
		key: String = T.uniqueIDKey,
		for value: Any,
		sortKey: String? = T.defaultSortingKey,
		isSortOrderAscending: Bool = T.isSortOrderAscending,
		comparisonType: PredicateComparisonType = .equal,
		fetchLimit: Int,
		context: EntityContext) -> [T]
	{
		let predicateFormat = "\(key)" + comparisonType.rawValue + "%@"
		let predicate = NSPredicate(format: predicateFormat, argumentArray: [value])
		var sortDescriptors: [NSSortDescriptor]?
		if let sortKey = sortKey { sortDescriptors = [NSSortDescriptor(key: sortKey, ascending: isSortOrderAscending)] }
		return objects(
			predicate: predicate,
			sortDescriptors: sortDescriptors,
			fetchLimit: fetchLimit,
			context: context)
	}
	
	public class func objects<T: EntityFetchInfoProvider>(
		predicate: NSPredicate? = nil,
		sortDescriptors: [NSSortDescriptor]? = nil,
		fetchLimit: Int,
		context: EntityContext) -> [T]
	{
		let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.entityName)
		request.predicate = predicate
		request.sortDescriptors = sortDescriptors
		request.fetchLimit = fetchLimit
		do {
			let managedContext = context as! NSManagedObjectContext
			let objects = try managedContext.fetch(request)
			return objects
		} catch {
			return []
		}
	}
}
