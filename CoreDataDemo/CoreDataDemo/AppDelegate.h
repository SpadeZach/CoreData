//
//  AppDelegate.h
//  CoreDataDemo
//
//  Created by 赵博 on 2017/6/9.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

