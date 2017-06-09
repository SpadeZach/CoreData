//
//  CoreDataManager.h
//  CoreData数据库
//
//  Created by 赵博 on 16/1/18.
//  Copyright © 2016年 赵博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject


+ (CoreDataManager *)defaultManger;
//数据管理器类（咨询师）
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模型（学生填的表）
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//数据连接器（职业规划师）
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
/**
 *  存储上下文(也就是我们对临时数据库，让它把真正的数据存入到真正的数据库中)
 */
- (void)saveContext;
/**
 *  打印路径
 *
 *  @return 返回的时document路径
 */
- (NSURL *)applicationDocumentsDirectory;




@end
