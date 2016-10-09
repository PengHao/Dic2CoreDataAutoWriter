//
//  ViewController.swift
//  CoreDataAutoParser
//
//  Created by 彭浩 on 16/7/23.
//  Copyright © 2016年 wolfpeng. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let modelURL = Bundle.main.url(forResource: "CoreDataAutoParser", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL) else {
            return
        }
        let coodinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        context.persistentStoreCoordinator = coodinator
        
        
//MARK: Example
        //origal data: Swift Dictionary
        let info = [
            "mBool"     :0,
            "mDate"     :1470391786.4013271,
            "mDouble"   :12321312123.3211231312,
            "mFloat"    :999.123,
            "mInt16"    :"1236",
            "mInt32"    :"12342141",
            "mInt64"    :"123789126651641293",
            "mString"   :"gdasd qweggdsa gdsa"
        ] as [String : Any]
        
        //convert to NSDictionary
        let infoDic = NSDictionary(dictionary: info)
        
        let entity = NSManagedObject.CreateWithMoc(context, entityName: "Entity", info: infoDic) { (description) -> NSManagedObject? in
            //insert a new object, or fetch a valid object
            let obj = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: self.context)
            return obj
        }
        //print the entity
        print("\(entity)")
        
        //print the entities' encode dictionary
        let en = entity?.enCode()
        print("\(en)")
        
        
        
        
        let mapInfo = [
            "key0" : 1,
            "key1" : 1470391786.4013271,
            "key2" : 12321312123.3211231312,
            "key3" : 999.123,
            "key4" : "1236",
            "key5" : "12342141",
            "key6" : "123789126651641293",
            "key7" : "gdasd qweggdsa gdsa"
            
        ] as [String : Any]
        
        let keyMap = [
            "mBool"     : "key0",
            "mDate"     : "key1",
            "mDouble"   : "key2",
            "mFloat"    : "key3",
            "mInt16"    : "key4",
            "mInt32"    : "key5",
            "mInt64"    : "key6",
            "mString"   : "key7",
            ]
        //convert to NSDictionary
        let mapInfoDic = NSDictionary(dictionary: mapInfo)
        let mapEntity = NSManagedObject.CreateWithMoc(context, entityName: "Entity", info: mapInfoDic, keyMap: keyMap) { (description) -> NSManagedObject? in
            let obj = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: self.context)
            return obj
        }
        //print the entity
        print("\(mapEntity)")
        
        //print the entities' encode dictionary
        let mapEn = mapEntity?.enCode()
        print("\(mapEn)")
    }

}

