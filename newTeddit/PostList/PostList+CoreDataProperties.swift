//
//  PostList+CoreDataProperties.swift
//  newTeddit
//
//  Created by prk on 18/12/22.
//
//

import Foundation
import CoreData


extension PostList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostList> {
        return NSFetchRequest<PostList>(entityName: "PostList")
    }

    @NSManaged public var judul: String?
    @NSManaged public var author: String?

}

extension PostList : Identifiable {

}
