//
//  NSDateFormatter+Category.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/23.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static id sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}
@end
