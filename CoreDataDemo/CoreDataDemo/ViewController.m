//
//  ViewController.m
//  CoreDataDemo
//
//  Created by 赵博 on 2017/6/9.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "ViewController.h"
#import "Student+CoreDataClass.h"
#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
@interface ViewController ()
@property(nonatomic, strong)CoreDataManager *coreDataManager;
@end

@implementation ViewController
- (CoreDataManager *)coreDataManager
{
    if (nil == _coreDataManager) {
        self.coreDataManager = [CoreDataManager defaultManger];
    }
    return _coreDataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
//增
- (IBAction)addData:(UIButton *)sender {
    Student *stu = [[Student alloc] initWithEntity:[NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.coreDataManager.managedObjectContext] insertIntoManagedObjectContext:self.coreDataManager.managedObjectContext];
    stu.name = [NSString stringWithFormat:@"劫%d",arc4random()%10];
    stu.sex = @"男";
    stu.age = @"21";
    [self.coreDataManager saveContext];
}
//删
- (IBAction)delegateData:(UIButton *)sender {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = '劫2'"];
    [request setPredicate:predicate];
    
    NSArray *arr = [self.coreDataManager.managedObjectContext executeFetchRequest:request error:nil];
    
    for (Student *s in arr) {
        // 利用数据管理器类 调用deleteObject方法 (后面参数就是我们的数据 NSManageObject(找到的s对象))
        [self.coreDataManager.managedObjectContext deleteObject:s];
    }
    
    [self.coreDataManager saveContext];
}
//改
- (IBAction)changeData:(UIButton *)sender {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = '劫2'"];
    [request setPredicate:predicate];
    
    NSArray *arr = [self.coreDataManager.managedObjectContext executeFetchRequest:request error:nil];
    
    for (Student *s in arr) {
        s.name = @"20投";
    }
    
    [self.coreDataManager saveContext];

}
//查
- (IBAction)search:(UIButton *)sender {
    //读取这个类
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    //建立请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //建立请求的是哪一类
    [request setEntity:entity];
    
    NSArray *array = [self.coreDataManager.managedObjectContext executeFetchRequest:request error:nil];
    for (Student *stu in array) {
        NSLog(@"%@",stu.name);
    }
}

@end
