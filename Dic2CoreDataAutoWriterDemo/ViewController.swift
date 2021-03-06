//
//  ViewController.swift
//  Dic2CoreDataAutoWriter
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
        
        let entity1 = Entity.insert(info: infoDic, context: context);
        print("\(String(describing: entity1))")
        
        let en = entity1?.enCode()
        print("\(String(describing: en))")
        
        
    }
}

