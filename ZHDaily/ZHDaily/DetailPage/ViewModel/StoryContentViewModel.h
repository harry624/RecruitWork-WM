//
//  StoryContentViewModel.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/27.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryContentModel.h"

@interface StoryContentViewModel : NSObject

@property (copy, nonatomic) NSNumber *loadedStoryID;
@property (strong ,nonatomic) StoryContentModel *stroyContentModel;
@property (strong, nonatomic) NSMutableArray *storiesID;
@property (copy, nonatomic) NSString *imageURLString;
@property (copy, nonatomic) NSAttributedString *titleAttributedString;
@property (copy, nonatomic) NSString *image_sourceText;

@property (copy, nonatomic) NSString *htmlString;
@property (copy, nonatomic) NSString *share_url;
@property (strong, nonatomic) NSArray *js;

- (void)getStoryContentWithStoryID:(NSNumber *)loadedStoryID;
- (void)getPreviousStoryContent;
- (void)getNextStoryContent;

@end
