//
//  Comment+CoreDataProperties.swift
//  newTeddit
//
//  Created by prk on 1/6/23.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var text: String?
    @NSManaged public var sender: String?
    @NSManaged public var date: Date?
    @NSManaged public var posts: Post?

}

extension Comment : Identifiable {

}
