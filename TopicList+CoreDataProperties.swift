//
//  TopicList+CoreDataProperties.swift
//  newTeddit
//
//  Created by prk on 19/12/22.
//
//

import Foundation
import CoreData


extension TopicList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopicList> {
        return NSFetchRequest<TopicList>(entityName: "TopicList")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var topicName: String?
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension TopicList {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: Posts)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: Posts)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}

extension TopicList : Identifiable {

}
