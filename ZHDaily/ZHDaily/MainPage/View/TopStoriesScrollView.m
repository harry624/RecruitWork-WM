//
//  TopStoriesScrollView.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "TopStoriesScrollView.h"
#import "TopStoriesView.h"
#import "ToolKit.h"

@interface TopStoriesScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TopStoriesScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureScrollView];
        [self configurePageControl];
    }
    return self;
}

- (void)configureScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 230.f)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 7, 230.f);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}

- (void)configurePageControl{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 210, kScreenWidth, 20.f)];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
}

@end
