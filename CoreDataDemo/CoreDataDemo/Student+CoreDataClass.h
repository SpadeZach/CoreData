//
//  Student+CoreDataClass.h
//  CoreDataDemo
//
//  Created by 赵博 on 2017/6/9.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSManagedObject
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * sex;
@end

NS_ASSUME_NONNULL_END

#import "Student+CoreDataProperties.h"
