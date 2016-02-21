//
//  TopStoriesView.m
//  ZhiHuDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "TopStoriesView.h"

@implementation TopStoriesView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:frame];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        _imageView = imgView;
        
        UILabel *titleLb = [[UILabel alloc]init];
        titleLb.numberOfLines = 0;
        [self addSubview:titleLb];
        _titleLabel = titleLb;
    }
    return self;
}
@end
