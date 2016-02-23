//
//  StoriesModel.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoriesModel : NSObject

@property(strong,nonatomic)NSArray *images;
@property(copy,nonatomic)NSNumber *storyID;
@property(copy,nonatomic)NSString *title;
@property(assign,nonatomic)BOOL isMultipic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;


@end
