//
//  StoryContentViewController.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/27.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
#import "ToolbarView.h"
#import "StoryContentViewModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface StoryContentViewController : ViewController
@property (strong, nonatomic) StoryContentViewModel *viewModel;

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *imgsoureLabel;

@property (strong, nonatomic) UIWebView *webView;


- (instancetype)initWithViewModel:(StoryContentViewModel *)viewModel;


@end
