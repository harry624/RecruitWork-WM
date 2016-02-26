//
//  TopStoriesScrollView.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopStoriesScrollViewDelegate <NSObject>

- (void)selectItemWithTag:(NSInteger)tag;

@end

@interface TopStoriesScrollView : UIView

@property (nonatomic, strong) NSArray *topStories;
@property (nonatomic, weak) id<TopStoriesScrollViewDelegate> delegate;

- (void)setTopStories:(NSArray *)topStories;
- (void)updateSubViewOriginY:(CGFloat)value;


@end
