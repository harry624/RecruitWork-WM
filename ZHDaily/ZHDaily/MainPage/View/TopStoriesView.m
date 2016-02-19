//
//  TopStoriesView.m
//  ZhiHuDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "TopStoriesView.h"

@implementation TopStoriesView

- (void)initwithImage: (UIImage *)image title:(NSString *)title{
        self.imageView.image = image;
        self.titleLabel.text = title;

    
}

@end
