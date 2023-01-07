//
//  Post+CoreDataProperties.swift
//  newTeddit
//
//  Created by prk on 1/6/23.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var author: String?
    @NSManaged public var judul: String?
    @NSManaged public var content: String?
    @NSManaged public var topics: Topic?
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension Post {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

extension Post : Identifiable {

}
