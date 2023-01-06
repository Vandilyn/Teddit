//
//  Topic+CoreDataProperties.swift
//  newTeddit
//
//  Created by prk on 1/6/23.
//
//

import Foundation
import CoreData


extension Topic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Topic> {
        return NSFetchRequest<Topic>(entityName: "Topic")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var name: String?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension Topic {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: Post)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: Post)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}

extension Topic : Identifiable {

}
