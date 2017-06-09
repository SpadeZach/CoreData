//
//  Student+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by 赵博 on 2017/6/9.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic sex;

@end
