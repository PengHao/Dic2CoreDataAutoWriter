//
//  EntityProtocol.swift
//  CoreDataAutoParser
//
//  Created by peng hao on 2017/6/2.
//  Copyright © 2017年 wolfpeng. All rights reserved.
//

import Foundation
import CoreData

protocol EntityProtocol {
}

extension EntityProtocol where Self : NSManagedObject {
    static func entityName() -> String? {
        let clsName = NSStringFromClass(object_getClass(self));
        return clsName.components(separatedBy: ".").last;
    }
    
    static func insert(info: AnyObject, context: NSManagedObjectContext) -> Self? {
        guard let className = entityName() else {
            return nil
        }
        let obj = NSEntityDescription.insertNewObject(forEntityName: className, into: context);
        obj.updateData(info: info);
        return obj as? Self;
    }
}
