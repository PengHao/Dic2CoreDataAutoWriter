//
//  CoreData+AutoParser.swift
//  WolfPeng
//
//  Created by penghao on 15/11/11.
//  Copyright © 2016年 wolfpeng. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    
    func updateData(info: AnyObject) {
        var _optionPropertiesList = [String]();
        for property in entity.properties {
            let attributeDesc = entity.attributesByName[property.name]
            if entity.relationshipsByName[property.name] != nil {
                _optionPropertiesList.append(property.name)
                continue
            }
            let key = property.name
            guard let v = info.value(forKey: key) else {
                if !property.isOptional {
                    print("Cannot find value of key \(key) in params")
                    return
                } else {
                    _optionPropertiesList.append(property.name)
                    continue
                }
            }
            if let attrClsName = attributeDesc?.attributeValueClassName,
                let cls = NSClassFromString(attrClsName) {
                if !(v as AnyObject).isKind(of: cls) {
                    var value: AnyObject? = nil
                    if attrClsName == "NSNumber" {
                        value = (v as AnyObject).doubleValue as AnyObject?
                    } else if attrClsName == "NSString" {
                        value = "\(v)" as AnyObject?
                    } else if attrClsName == "NSDate" {
                        if let d = (v as AnyObject).doubleValue {
                            value = Date(timeIntervalSince1970: d) as AnyObject?
                        }
                    }
                    if value != nil {
                        self.setValue(value, forKey: property.name)
                    } else if !property.isOptional {
                        print("Params value of key \(property.name)'s type is invalide, required is \(attrClsName), value is \(v)")
                    }
                } else {
                    self.setValue(v, forKey: property.name)
                }
            } else {
                print("Cannot find value of key \(key) in params")
            }
        }
    }
    
/**
 *  This founction is used to encoding Entity instance to a dictionary
 **/
    
    public func enCode() -> [String: Any] {
        var rs = [String: Any]()
        for property in entity.properties {
            if let v = value(forKey: property.name) {
                if let m = v as? NSManagedObject {
                    rs[property.name] = m.enCode()
                }
                rs[property.name] = value(forKey: property.name)
            }
        }
        return rs
    }
}
