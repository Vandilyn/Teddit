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

}

extension TopicList : Identifiable {

}
