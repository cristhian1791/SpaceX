//
//  LinksCore+CoreDataProperties.swift
//  
//
//  Created by Cristhian on 29/12/23.
//
//

import Foundation
import CoreData


extension LinksCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LinksCore> {
        return NSFetchRequest<LinksCore>(entityName: "LinksCore")
    }

    @NSManaged public var articleLink: String?
    @NSManaged public var youtubeID: String?
    @NSManaged public var flickrImages: [String]?
    @NSManaged public var launchesRelation: NSSet?

}

// MARK: Generated accessors for launchesRelation
extension LinksCore {

    @objc(addLaunchesRelationObject:)
    @NSManaged public func addToLaunchesRelation(_ value: LaunchesCore)

    @objc(removeLaunchesRelationObject:)
    @NSManaged public func removeFromLaunchesRelation(_ value: LaunchesCore)

    @objc(addLaunchesRelation:)
    @NSManaged public func addToLaunchesRelation(_ values: NSSet)

    @objc(removeLaunchesRelation:)
    @NSManaged public func removeFromLaunchesRelation(_ values: NSSet)

}
