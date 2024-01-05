//
//  LaunchesCore+CoreDataProperties.swift
//  
//
//  Created by Cristhian on 29/12/23.
//
//

import Foundation
import CoreData


extension LaunchesCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LaunchesCore> {
        return NSFetchRequest<LaunchesCore>(entityName: "LaunchesCore")
    }

    @NSManaged public var dateLocal: String?
    @NSManaged public var dateUnix: Float
    @NSManaged public var details: String?
    @NSManaged public var missionName: String?
    @NSManaged public var missionPatchUrl: String?
    @NSManaged public var rocketName: String?
    @NSManaged public var rocketType: String?
    @NSManaged public var siteName: String?
    @NSManaged public var siteNameLong: String?
    @NSManaged public var linkRelation: LinksCore?

}
