//
//  TopStoriesScrollView.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopStoriesScrollView : UIView

@property (nonatomic, strong) NSArray *topStories;

- (void)setTopStories:(NSArray *)topStories;
@end
