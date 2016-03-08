//
//  StoryDetail.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/27.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryContentModel : NSObject

@property (copy, nonatomic) NSString *body;
@property (copy, nonatomic) NSString *image_source;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *share_url;
@property (strong, nonatomic) NSArray *js;
@property (copy, nonatomic) NSNumber *storyID;
@property (strong, nonatomic) NSArray *css;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
