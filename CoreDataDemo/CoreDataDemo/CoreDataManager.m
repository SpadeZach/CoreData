//
//  CoreDataManager.m
//  CoreData数据库
//
//  Created by 赵博 on 16/1/18.
//  Copyright © 2016年 赵博. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager 
+ (CoreDataManager *)defaultManger
{
    static CoreDataManager *core = nil;
    static dispatch_once_t onceToc;
    dispatch_once(&onceToc, ^{
        core = [[CoreDataManager alloc] init];
    });
    return core;
}


#pragma mark - Core Data stack
/**
 *  @synthesize 在iOS6以前被它修饰的变量，在编译期间会自动生成setter,getter方法，如果我们重写了setter,getter方法则响应我们自己重写的，(只能在.m中使用)
 */

// @dyanmic 在程序编译期间 不自动生成seter getter方法，然后再运行期间如果我们没重写setter getter方法则在这个时候系统自动生成seter getter方法（一般CoreData  生成）

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "--.CoreData___" in the application's documents directory.
    NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    //在我们的沙盒里找到CoreData.xcdatamodeld的路径
    //xcdatamodeld 在程序运行时会自动给转换成momd类型
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:<#输入CoreData名#> withExtension:@"momd"];
    
    //初始化 利用找到的CoreData.xcdatamodeld 初始化我们的数据模型
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    //利用拿到的Model来初始化我们的数据连接器
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    //创建本地真正数据库的路径（真正的数据库的名字可以自己起，但是必须sqlite结尾）
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData___.sqlite"];
    
    NSError *error = nil;
    
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    //如果你需要CoreData拥有自动迭代功能，这个字典必须写
    NSDictionary *dic = @{NSMigratePersistentStoresAutomaticallyOption:@(YES), NSInferMappingModelAutomaticallyOption:@(YES)};
    //给我们的数据连接器设置一些参数
    /**
     *  参数1.设置俩接到得数据库类型 （NSSQLiteStoreType）
     *  参数2.一些配置 （暂时不需要nil）
     *  参数3.真正数据库路径
     *  参数4.一些配置
     *  参数5.错误信息
     */
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:dic error:&error]) {
        //如果数据连接器添加一些参数失败时会进入这个if条件
        
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        //手动crash处理（也就是CoreData产生异常或者错误，直接停到这里）
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    //获取数据连接器
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    //初始化 （这个Xcode7.0以后使用initWithConcurrencyType 初始化）
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //数据库管理类  设置连接器
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    
    if (managedObjectContext != nil) {
        NSError *error = nil;
#warning 数据管理器类 调用save方法，把临时数据库里的数据存入到真正数据库中
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
