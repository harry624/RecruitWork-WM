//
//  TopStoriesScrollView.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/19.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "TopStoriesScrollView.h"
#import "ToolKit.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TopStoriesView.h"
#import "TopstoriesModel.h"
#import "UIView+Extension.h"

@interface TopStoriesScrollView () <UIScrollViewDelegate>{
    TopStoriesView *view;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIGestureRecognizer *tapGesture;
@end

@implementation TopStoriesScrollView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.topStories = [[NSArray alloc]init];
        _tapGesture = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        self.topStories = [NSArray array];
        [self configureScrollView];
        [self configurePageControl];
    }
    return self;
}

- (void)setTopStories:(NSArray *)topStories{
    [_timer invalidate];
    _pageControl.numberOfPages = topStories.count - 2;
    _pageControl.currentPage = 0;
    _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    
    for (int i = 0; i < topStories.count; i++) {
        TopstoriesModel *model = topStories[i];
        view = [_scrollView viewWithTag:100+i];
        [view.imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc]initWithString:model.title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                                                                                                  NSForegroundColorAttributeName:[UIColor whiteColor]}];
        CGSize size = [attributedString boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 200) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        view.titleLabel.frame = CGRectMake(15, 0, kScreenWidth - 30, size.height);
        
        CGRect frame = view.titleLabel.frame;
        frame.origin.y = kScrollViewHeiget - frame.size.height - 20;
        view.titleLabel.frame = frame;
        [view.titleLabel setAttributedText:attributedString];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(nextTopStory) userInfo:nil repeats:YES];
}

#pragma mark - Configurations
- (void)configureScrollView{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300.f)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 7, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];

    for (int i = 0; i < 7; i++) {
        view = [[TopStoriesView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, 300.f)];
        [view addGestureRecognizer:_tapGesture];
        [view setTag:100+ i];
        [_scrollView addSubview:view];
    }
}

- (void)configurePageControl{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 20.f, kScreenWidth, 20.f)];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.enabled = NO;
    [self addSubview:_pageControl];
}


#pragma mark - Next page
- (void)nextTopStory{
    [_scrollView setContentOffset:CGPointMake(kScreenWidth + _scrollView.contentOffset.x ,0) animated:YES];
}

- (void)tap:(UIGestureRecognizer*)recoginizer{
    [self.delegate selectItemWithTag:recoginizer.view.tag];
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX == kScreenWidth *6) {
        scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
        _pageControl.currentPage = 0;
    }else if(offsetX == 0){
        scrollView.contentOffset = CGPointMake(5 *kScreenWidth, 0);
        _pageControl.currentPage = 4;
    }else{
        _pageControl.currentPage = offsetX/kScreenWidth - 1;
    }
}

- (void)updateSubViewOriginY:(CGFloat)value{
    [_pageControl setBottom:260.f - value/2];
    NSUInteger index = _scrollView.contentOffset.x / kScreenWidth;
    TopStoriesView *topstoriesView = [_scrollView viewWithTag: index + 100];
    [topstoriesView.titleLabel setBottom:_pageControl.top];
 }

@end
