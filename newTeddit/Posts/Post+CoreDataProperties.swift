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
        let req =  NSFetchRequest<Post>(entityName: "Post")
        return req
    }

    @NSManaged public var author: String?
    @NSManaged public var judul: String?
    @NSManaged public var topics: Topic?

}

extension Post : Identifiable {

}
