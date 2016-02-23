//
//  StoriesTableViewCell.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/21.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoriesModel.h"
@interface StoriesTableViewCell : UITableViewCell

@property (nonatomic, strong) StoriesModel *model;


- (void)setStoryModel:(StoriesModel *)model;
@end
