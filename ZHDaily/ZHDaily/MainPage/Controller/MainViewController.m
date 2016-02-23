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
#import "StoriesTableViewCell.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>{
    UITableView *_mainTableView;
    TopStoriesScrollView *_scrollView;
    
}
@property (nonatomic, strong) NSArray <TopstoriesModel *> *topStoiresModelArray;
@property (nonatomic, strong) MainPageViewModel *viewmodel;
@property (nonatomic, strong) UIView *naviBarView;
@property(weak,nonatomic)UILabel *newsTodayLb;

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
    _scrollView = [[TopStoriesScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrollViewHeiget)];
    _scrollView.clipsToBounds = YES;

    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [_mainTableView registerNib:[UINib nibWithNibName:@"StoriesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    _mainTableView.tableHeaderView = _scrollView;
    [self.view addSubview:_mainTableView];
}

- (void)setupNavibar{
    UIView *naviagtionBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 56.f)];
    naviagtionBarView.backgroundColor = [UIColor colorWithRed:60.f/255.f green:198.f/255.f blue:253.f/255.f alpha:0.f];
    [self.view addSubview:naviagtionBarView];
    _naviBarView = naviagtionBarView;
    
    UILabel *label = [[UILabel alloc]init];
    label.attributedText = [[NSAttributedString alloc]initWithString:@"今日新闻" attributes:
                            @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [label sizeToFit];
    [label setCenter:CGPointMake(self.view.center.x, 38)];
    [self.view addSubview:label];
    _newsTodayLb = label;
    
    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(_newsTodayLb.frame.origin.x - 20.f, _newsTodayLb.center.y - 10.f, 20.f, 20.f)];
    [menuButton setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(showleftMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButton];

}

#pragma mark - Noitifications
- (void)loadingLatestDaily:(NSNotification *)noti{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [_mainTableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    [self setTopStoriesContent];
}

- (void)loadingPreviousDaily:(NSNotification *)noti{
    
}

- (void)updateLatestDaily:(NSNotification *)noti{
    
}

#pragma mark - Methods
- (void)setTopStoriesContent{
    [_scrollView setTopStories:self.viewmodel.topstories];
}

- (void)showleftMenu:(id)sender{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.viewController showLeftMenu];
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
        cell = [[StoriesTableViewCell alloc]init];
        StoriesModel *model = [self.viewmodel storyAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setStoryModel:model];
        return cell;
}


#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88.f;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
