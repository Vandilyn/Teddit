//
//  Posts+CoreDataProperties.swift
//  newTeddit
//
//  Created by prk on 18/12/22.
//
//

import Foundation
import CoreData


extension Posts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts")
    }

    @NSManaged public var judul: String?
    @NSManaged public var author: String?

}

extension Posts : Identifiable {

}
