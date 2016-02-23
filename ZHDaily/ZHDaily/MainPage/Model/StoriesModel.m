//
//  StoriesModel.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "StoriesModel.h"

@implementation StoriesModel


- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forUndefinedKey:@"storyID"];
    }
    if ([key isEqualToString:@"multipic"]) {
        [self setValue:value forUndefinedKey:@"isMultipic"];
    }
}


@end
