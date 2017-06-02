# CoreDataAutoParser
自动将对应的字典类型数据转化为CoreData的存储类型，entity需要实现EntityProtocol接口，然后直接调用insert方法既可以插入一个新的entity，也可以调用updateData方法直接更新数据

class Entity: NSManagedObject, EntityProtocol 

let entity1 = Entity.insert(info: infoDic, context: context);