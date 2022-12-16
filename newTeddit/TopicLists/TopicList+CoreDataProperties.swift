//
//  TopicList+CoreDataProperties.swift
//  newTeddit
//
//  Created by prk on 12/15/22.
//
//

import Foundation
import CoreData


extension TopicList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TopicList> {
        return NSFetchRequest<TopicList>(entityName: "TopicList")
    }

    @NSManaged public var topicName: String?
    @NSManaged public var createdAt: Date?

}

extension TopicList : Identifiable {

}
