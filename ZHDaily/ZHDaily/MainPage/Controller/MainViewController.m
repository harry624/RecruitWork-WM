//
//  MainViewController.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//
#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "NetManager.h"
#import "ToolKit.h"
#import "TopstoriesModel.h"
#import "StoriesModel.h"
#import "MainPageViewModel.h"
#import "TopStoriesScrollView.h"
#import "RefreshView.h"
#import "SectionTitleView.h"
#import "StoriesTableViewCell.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSArray <TopstoriesModel *> *topStoiresModelArray;
@property (nonatomic, strong) MainPageViewModel *viewmodel;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) TopStoriesScrollView *scrollView;
@property (nonatomic, strong) RefreshView *refreshView;
@property (nonatomic, strong) UIView *naviBarView;
@property (nonatomic, strong) SectionTitleView *sectionTitleView;
@property (nonatomic, weak)UILabel *newsTodayLb;

@end

@implementation MainViewController{
    NSArray *_storiesModelArray;
}

- (instancetype)initWithViewModel:(MainPageViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewmodel = viewModel;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingLatestDaily:) name:@"LoadLatestDaily" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingPreviousDaily:) name:@"LoadPreviousDaily" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLatestDaily:) name:@"UpdateLatestDaily" object:nil];
        
        [self.viewmodel getLatestStories];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self setupNavibar];
}
#pragma mark - View Configurations
- (void)setupSubViews{
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20.f, kScreenWidth, kScreenHeight - 20.f)];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    _mainTableView.showsHorizontalScrollIndicator = NO;
    _mainTableView.showsVerticalScrollIndicator = NO;
    [_mainTableView registerNib:[UINib nibWithNibName:@"StoriesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    _mainTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200.f)];
    [self.view addSubview:_mainTableView];
    
    [_mainTableView registerClass:[SectionTitleView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([SectionTitleView class])];
    TopStoriesScrollView *scrollView = [[TopStoriesScrollView alloc]initWithFrame:CGRectMake(0, -40.f, kScreenWidth, 260.f)];
    scrollView.clipsToBounds = YES;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

- (void)setupNavibar{
    UIView *naviagtionBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 56.f)];
    naviagtionBarView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];
    [self.view addSubview:naviagtionBarView];
    _naviBarView = naviagtionBarView;
    
    //navi title
    UILabel *label = [[UILabel alloc]init];
    label.attributedText = [[NSAttributedString alloc]initWithString:@"今日新闻" attributes:
                            @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [label sizeToFit];
    [label setCenter:CGPointMake(self.view.center.x, 38)];
    [self.view addSubview:label];
    _newsTodayLb = label;
    
    //navi button
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(16.f, 18.f, 22.f, 22.f)];
    [menuButton setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(showleftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButton];
    
    //navi Refresh image
    RefreshView *refreshView = [[RefreshView alloc]initWithFrame:CGRectMake(_newsTodayLb.frame.origin.x - 20.f, _newsTodayLb.center.y - 10.f, 20.f, 20.f)];
    [self.view addSubview:refreshView];
    _refreshView = refreshView;
}

#pragma mark - Noitifications
- (void)loadingLatestDaily:(NSNotification *)noti{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_mainTableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    [self setTopStoriesContent];
}

- (void)loadingPreviousDaily:(NSNotification *)noti{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex: [self.viewmodel numberOfSection] - 1];
    [_mainTableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)updateLatestDaily:(NSNotification *)noti{
    if (![noti.userInfo[@"isNewDay"] boolValue]) {
        NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:0];
        [_mainTableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationFade];
        [self setTopStoriesContent];
    }else{
        [_mainTableView reloadData];
        [self setTopStoriesContent];
    }
}

#pragma mark - Table View DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger number =[self.viewmodel numberOfSection];
    return number;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger numberOfRows =[self.viewmodel numberOfRowsInSection:section];
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        StoriesModel *model = [self.viewmodel storyAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setStoryModel:model];
        return cell;
}


#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 36.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    SectionTitleView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([SectionTitleView class])];
    headerView.contentView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:255.f/255.f alpha:1.f];
    headerView.textLabel.attributedText = [self.viewmodel titileForSection:section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (section == 0) {
        CGRect frame = _naviBarView.frame;
        frame.size.height = 56.f;
        _naviBarView.frame = frame;
        _newsTodayLb.alpha = 1.f;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (section == 0) {
        CGRect frame = _naviBarView.frame;
        frame.size.height = 20.f;
        _naviBarView.frame = frame;
        _newsTodayLb.alpha = 0.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_mainTableView]) {
        //下拉刷新，navibar颜色渐变
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY <= 0 && offsetY >= -80) {
            if (-offsetY <= 40 ) {
                if (!_viewmodel.isLoading) {
                    [_refreshView RedrawFromProgress:-offsetY/40];
                }else{
                    [_refreshView RedrawFromProgress:0];
                }
            }
            
            if (-offsetY > 40 && -offsetY <= 80 && !scrollView.isDragging && !_viewmodel.isLoading) {
                [self.viewmodel updateLatestStories];
                [_refreshView startAnimation];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [_refreshView stopAnimation];
                });
            }
            _scrollView.frame = CGRectMake(0, -40.f -offsetY/2, kScreenWidth, 260 - offsetY/2);
            [_scrollView updateSubViewOriginY:offsetY];
            _naviBarView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:255.f/255.f alpha:0.f];
        }else if (offsetY < -80){
            _mainTableView.contentOffset = CGPointMake(0.f, -80.f);
        }else if (offsetY <= 300){
            [_refreshView RedrawFromProgress:0];
            _scrollView.frame = CGRectMake(0,  -40.f -offsetY, kScreenWidth, 260.f);
            _naviBarView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:255.f/255.f alpha:offsetY/(220.f - 56.f)];
        }
        
        //上拉刷新
        if (offsetY + kCellHeight > scrollView.contentSize.height - kScreenHeight) {
            if (!_viewmodel.isLoading) {
                [_viewmodel getPreviousStories];
            }
        }
    }
}

#pragma mark - Methods
- (void)setTopStoriesContent{
    [_scrollView setTopStories:self.viewmodel.topstories];
}

- (void)showleftMenu:(id)sender{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.viewController showLeftMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
