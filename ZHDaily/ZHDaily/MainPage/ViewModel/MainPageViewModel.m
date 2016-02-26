//
//  MainPageViewModel.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/23.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "MainPageViewModel.h"
#import <UIKit/UIKit.h>
#import "StoriesModel.h"
#import "TopstoriesModel.h"
#import "NSDateFormatter+Category.h"
#import "NetManager.h"

@interface SectionViewModel : NSObject

@property (nonatomic, copy) NSString *sectionTitleText;
@property (nonatomic, strong) NSArray *sectionDataSource;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

@implementation SectionViewModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.sectionTitleText = [self stringConvertToSectionTitleText:dic[@"date"]];
        NSArray *stories = dic[@"stories"];
        NSMutableArray *storyModelList = [NSMutableArray new];
        for (NSDictionary *storyDic in stories) {
            StoriesModel *model = [[StoriesModel alloc]initWithDictionary:storyDic];
            [storyModelList addObject:model];
        }
        self.sectionDataSource = storyModelList;
    }
    return self;
}

- (NSString *)stringConvertToSectionTitleText:(NSString *)string{
    NSDateFormatter *formatter = [NSDateFormatter sharedInstance];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:string];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CH"];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *sectionTitleText = [formatter stringFromDate:date];
    
    return sectionTitleText;
}

@end

@interface MainPageViewModel ()

@property (nonatomic, copy) NSString *currentLoadDayStr; //latestNews那天的日期字符串

@end
@implementation MainPageViewModel

- (NSUInteger)numberOfSection{
    return self.dayDataList.count;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section{
    SectionViewModel *sectionViewModel = _dayDataList[section];
    return sectionViewModel.sectionDataSource.count;
}

- (NSAttributedString *)titileForSection:(NSInteger)section{
    SectionViewModel *sectionViewModel = _dayDataList[section];

    return     [[NSAttributedString alloc]initWithString:sectionViewModel.sectionTitleText attributes:@{
                                                NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]
                }];
}
- (StoriesModel *)storyAtIndexPath:(NSIndexPath *)indexPath{
    SectionViewModel *secitonViewModel = _dayDataList[indexPath.section];
    StoriesModel *story = secitonViewModel.sectionDataSource[indexPath.row];
    return story;
}

//获取最新的新闻

- (void)getLatestStories{
    [NetManager getLatestNewsWithsuccess:^(id JSON) {
        NSDictionary *jsonDic = (NSDictionary *)JSON;
        self.currentLoadDayStr = JSON[@"date"];
        
        SectionViewModel *viewModel = [[SectionViewModel alloc]initWithDictionary:jsonDic];
        _dayDataList = [NSMutableArray arrayWithObject:viewModel];
        _storiesID = [NSMutableArray arrayWithArray:[viewModel valueForKeyPath:@"sectionDataSource.storyID"]];
        
        NSArray *topstories = jsonDic[@"top_stories"];
        NSMutableArray *topStoryModelList = [NSMutableArray new];
        for (NSDictionary *topstoryDic in topstories) {
            TopstoriesModel *model = [[TopstoriesModel alloc]initWithDictionary:topstoryDic];
            [topStoryModelList addObject:model];
        }
        TopstoriesModel *firstTopStory = [topStoryModelList firstObject];
        TopstoriesModel *lastTopStroy = [topStoryModelList lastObject];
        [topStoryModelList insertObject:lastTopStroy atIndex:0];
        [topStoryModelList addObject:firstTopStory];
        [self setValue:topStoryModelList forKey:@"topstories"];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadLatestDaily" object:nil];
    }];
}

- (void)updateLatestStories{
    _isLoading = YES;
    [NetManager getLatestNewsWithsuccess:^(id JSON) {
        NSDictionary *jsonDic = (NSDictionary *)JSON;
        
        NSArray *topStories = jsonDic[@"top_stories"];
        NSMutableArray *topStoryModelList = [NSMutableArray new];
        for (NSDictionary *topStory in topStories) {
            TopstoriesModel *model = [[TopstoriesModel alloc]initWithDictionary:topStory];
            [topStoryModelList addObject:model];
        }
        TopstoriesModel *firstTopStory = [topStoryModelList firstObject];
        TopstoriesModel *lastTopStroy = [topStoryModelList lastObject];
        [topStoryModelList insertObject:lastTopStroy atIndex:0];
        [topStoryModelList addObject:firstTopStory];
        [self setValue:topStoryModelList forKey:@"topstories"];
        
        SectionViewModel *newVM = [[SectionViewModel alloc]initWithDictionary:jsonDic];
        SectionViewModel *oldVM = _dayDataList[0];
        
        if ([newVM.sectionTitleText isEqualToString:oldVM.sectionTitleText]) {
            NSArray *new = newVM.sectionDataSource;
            NSArray *old = oldVM.sectionDataSource;
            if (new.count > old.count) {
                NSUInteger newItemsCount = new.count - old.count;
                for (int i = 1; i < newItemsCount; i++) {
                    StoriesModel *model = new[newItemsCount - i];
                    [_storiesID insertObject:model.storyID atIndex:0];
                }
                [_dayDataList removeObject:oldVM];
                [_dayDataList insertObject:newVM atIndex:0];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLatestDaily" object:nil];
        }else{
            _currentLoadDayStr = JSON[@"date"];
            _dayDataList = [NSMutableArray arrayWithObject:newVM];
            _storiesID = [NSMutableArray arrayWithArray:[newVM valueForKey:@"sectionDataSource.storyID"]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateLatestDaily" object:nil userInfo:@{@"isNewDay":@(YES)}];
        }
        _isLoading = NO;
    }];
    
}

- (void)getPreviousStories{
    _isLoading = YES;
    [NetManager getPreviousNewsWithdate:_currentLoadDayStr success:^(id JSON) {
        NSDictionary *jsonDic = (NSDictionary *)JSON;
        self.currentLoadDayStr = JSON[@"date"];
        SectionViewModel *vm = [[SectionViewModel alloc]initWithDictionary:jsonDic];
        [_dayDataList addObject:vm];
        [_storiesID addObjectsFromArray:[vm valueForKeyPath:@"sectionDataSource.storyID"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadPreviousDaily" object:nil];
        _isLoading = NO;
    }];
}

@end
