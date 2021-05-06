//
//  Member+CoreDataProperties.swift
//  Parliament-Task
//
//  Created by iosdev on 4.5.2021.
//
//

import Foundation
import CoreData
import UIKit


extension Member {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }
    
    @NSManaged public var hetekaId: Int64
    @NSManaged public var seatNumber: Int64
    @NSManaged public var lastname: String?
    @NSManaged public var firstname: String?
    @NSManaged public var party: String?
    @NSManaged public var minister: Bool
    @NSManaged public var pictureUrl: String?
    
}

extension Member : Identifiable {
    
}
