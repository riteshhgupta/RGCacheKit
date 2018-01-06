//
//  EntityFetchInfoProvider.swift
//  RGCacheKit
//
//  Created by Ritesh Gupta on 03/01/18.
//  Copyright © 2018 Ritesh Gupta. All rights reserved.
//

import Foundation
import CoreData

public protocol EntityFetchInfoProvider: class, NSFetchRequestResult {
	
	static var uniqueIDKey: String { get }
	static var entityName: String { get }
	static var defaultSortingKey: String? { get }
	static var isSortOrderAscending: Bool { get }
}

public extension EntityFetchInfoProvider {
	
	static var entityName: String { return String(describing: self) }
	static var defaultSortingKey: String? { return nil }
	static var isSortOrderAscending: Bool { return true }
}

