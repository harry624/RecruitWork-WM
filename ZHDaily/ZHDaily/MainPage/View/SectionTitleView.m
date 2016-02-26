//
//  SectionTitleView.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/26.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "SectionTitleView.h"

@implementation SectionTitleView

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}
@end
