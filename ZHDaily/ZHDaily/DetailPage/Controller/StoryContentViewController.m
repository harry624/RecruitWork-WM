//
//  StoryContentViewController.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/27.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "StoryContentViewController.h"

@interface StoryContentViewController ()<UIScrollViewDelegate,UIWebViewDelegate,ToolBarDelegate>

@end

@implementation StoryContentViewController

- (instancetype)initWithViewModel:(StoryContentViewModel *)viewModel{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        [_viewModel addObserver:self forKeyPath:@"stroyContentModel" options:NSKeyValueObservingOptionNew context:nil];
        [_viewModel getStoryContentWithStoryID:_viewModel.loadedStoryID];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureWebView];
    [self configureHeaderView];
    [self configureToolBar];
}

- (void)dealloc{
    [_viewModel removeObserver:self forKeyPath:@"stroyContentModel"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Configuration
- (void)configureHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -40.f, kScreenWidth, 260.f)];
    _headerView.clipsToBounds = YES;
    [self.view addSubview: _headerView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300.f)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview: _imageView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.numberOfLines = 0;
    [_headerView addSubview:_titleLabel];
    
    _imgsoureLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 240.f, kScreenWidth - 20.f, 20.f)];
    _imgsoureLabel.textAlignment = NSTextAlignmentRight;
    _imgsoureLabel.font = [UIFont systemFontOfSize:12];
    _imgsoureLabel.textColor = [UIColor whiteColor];
    [_headerView addSubview:_imgsoureLabel];

}

- (void)configureWebView{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20.f, kScreenWidth, kScreenHeight - 20 - 40)];
    _webView.delegate = self;
    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
}

- (void)configureToolBar{
    ToolbarView *toolBarView = [[ToolbarView alloc]initWithFrame:CGRectMake(0.f, kScreenHeight - 44.f, kScreenWidth, 44)];
    NSLog(@"toolbarwidth:%f",toolBarView.frame.size.width);
    toolBarView.delegate =self;
    [self.view addSubview:toolBarView];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"stroyContentModel"]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.imageURLString]];
        
        CGSize size = [_viewModel.titleAttributedString boundingRectWithSize:CGSizeMake(kScreenWidth - 30, 60) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
        
        _titleLabel.frame = CGRectMake(15, _headerView.frame.size.height - 20 - size.height, kScreenWidth - 30, size.height);
        
        _imgsoureLabel.text = _viewModel.image_sourceText;
        
        [_webView loadHTMLString:_viewModel.htmlString baseURL:nil];
         
    }
}

#pragma mark - Next/previous Story;
- (void)previousStory{
    
}

- (void)nextStory{
    
}

#pragma mark - ToolBar button Action delegate
- (void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"back cliked");

}

- (void)nextAction:(id)sender{
    [_viewModel getNextStoryContent];
    NSLog(@"next cliked");
}

- (void)votedAction:(id)sender{
    NSLog(@"vote cliked");
}

- (void)shareAction:(id)sender{
    NSLog(@"share cliked");
}

- (void)commentAction:(id)sender{
    NSLog(@"comment cliked");
}

@end
