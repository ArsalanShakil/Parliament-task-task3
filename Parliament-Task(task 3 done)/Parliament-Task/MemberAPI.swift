//
//  MemberAPI.swift
//  Parliament-Task
//
//  Created by iosdev on 4.5.2021.
//

import Foundation
import UIKit
import CoreData

class MemberAPI {
    
    func memberData() {
        let context = AppDelegate.viewContext
        let apiUrl = "https://avoindata.eduskunta.fi/api/v1/seating/"
        
        guard let url = URL(string: apiUrl) else {
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Client error \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("http response error")
                return
            }
            
            guard let data = data else {
                return
            }
            
            
            do {
                let members = try JSONDecoder().decode([MyResult].self, from: data)
                
                for member in members {
                    context.perform{
                        Member.createMemberManagedObject(member)
                        try? context.save()
                    }
                }
                
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
    
    
}

struct MyResult: Codable {
    var hetekaId: Int64
    var seatNumber: Int64
    var lastname: String
    var firstname: String
    var party: String
    var minister: Bool
    var pictureUrl: String
}

enum CodingKeys: String, CodingKey {
    case hetekaId
    case seatNumber
    case lastname
    case firstname
    case party
    case minister
    case pictureUrl
}

