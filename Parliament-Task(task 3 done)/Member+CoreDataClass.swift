//
//  Member+CoreDataClass.swift
//  Parliament-Task
//
//  Created by iosdev on 4.5.2021.
//
//

import Foundation
import CoreData
import UIKit


public class Member: NSManagedObject {
    class  func createMemberManagedObject (_ member: MyResult) {
        
        let request: NSFetchRequest<Member> = Member.fetchRequest()
        
        request.predicate = NSPredicate(format: "hetekaId = %d", member.hetekaId)
        
        let context = AppDelegate.viewContext
        
        if let matchingMember = try? context.fetch(request) {
            if(matchingMember.count == 0) {
                let newMember = Member(context: context)
                newMember.hetekaId = member.hetekaId
                newMember.seatNumber = member.seatNumber
                newMember.lastname = member.lastname
                newMember.firstname = member.firstname
                newMember.party = member.party
                newMember.minister = member.minister
                newMember.pictureUrl = member.pictureUrl
            }
        }
        
        
    }
    
}
