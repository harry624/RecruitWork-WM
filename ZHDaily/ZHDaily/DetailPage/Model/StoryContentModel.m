//
//  StoryDetail.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/27.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "StoryContentModel.h"

@implementation StoryContentModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"storyID"];
    }
}

@end
