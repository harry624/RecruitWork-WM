//
//  MainPageViewModel.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/23.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoriesModel;

@interface MainPageViewModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *dayDataList;
@property (nonatomic, strong, readonly) NSMutableArray *topstories;
@property (nonatomic, assign, readonly) BOOL isLoading;
@property (nonatomic, strong, readonly) NSMutableArray *storiesID;

- (void)getLatestStories;
- (void)getPreviousStories;
- (void)updateLatestStories;

- (NSUInteger)numberOfSection;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (NSAttributedString *)titileForSection:(NSInteger)section;
- (StoriesModel *)storyAtIndexPath:(NSIndexPath *)indexPath;

@end
