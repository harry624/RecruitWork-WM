//
//  StoryContentViewModel.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/27.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "StoryContentViewModel.h"
#import "NetManager.h"

@implementation StoryContentViewModel

- (NSString *)imageURLString {
    return _stroyContentModel.image;
}

- (NSAttributedString *)titleAttributedString{
    return [[NSAttributedString alloc]initWithString:_stroyContentModel.title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:21], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (NSString *)image_sourceText{
    return [NSString stringWithFormat:@"图片：%@", _stroyContentModel.image_source];
}

- (NSString *)htmlString{
    return [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>", _stroyContentModel.css[0], _stroyContentModel.body];
}


- (void)getStoryContentWithStoryID:(NSNumber *)loadedStoryID{
    [NetManager getStoryDetailWithId:[loadedStoryID stringValue] success:^(id JSON) {
        NSDictionary *jsonDic = (NSDictionary *)JSON;
        StoryContentModel *model = [[StoryContentModel alloc]initWithDictionary:jsonDic];
        [self setValue:model forKey:@"stroyContentModel"];
        _loadedStoryID = loadedStoryID;
    }];
}

- (void)getPreviousStoryContent{
    NSInteger index = [_storiesID indexOfObject:_loadedStoryID];
    if (--index >= 0) {
        NSNumber *previousStoryID = [_storiesID objectAtIndex:index];
        [self getStoryContentWithStoryID:previousStoryID];
    }
}

- (void)getNextStoryContent{
    NSInteger index = [_storiesID indexOfObject:_loadedStoryID];
    if (++index < _storiesID.count) {
        NSNumber *nextStoryID = [_storiesID objectAtIndex:index];
        [self getStoryContentWithStoryID:nextStoryID];
    }
}
@end
