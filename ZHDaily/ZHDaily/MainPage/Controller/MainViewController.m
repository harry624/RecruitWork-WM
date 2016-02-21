//
//  MainViewController.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "MainViewController.h"
#import "NetManager.h"
#import "ToolKit.h"
#import "TopstoriesModel.h"
#import "StoriesModel.h"
#import "TopStoriesScrollView.h"
#import "StoriesTableViewCell.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UITableView *mainTableView;
    TopStoriesScrollView *scrollView;
    
}
@property (nonatomic, strong) NSArray <TopstoriesModel *> *topStoiresModelArray;
@property (nonatomic, strong) NSArray <StoriesModel *> *storiesModelArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLatestNews];
    [self setupSubViews];
}

- (void)getLatestNews{
    [NetManager getLatestNewsWithsuccess:^(id JSON) {
        [self serilizeTopStories:JSON[@"top_stories"]];
        [self serilizeStories:JSON[@"stories"]];
    }];
}

- (void)setupSubViews{
    scrollView = [[TopStoriesScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrollViewHeiget)];
    
    mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.tableHeaderView = scrollView;
    [self.view addSubview:mainTableView];
    
    [mainTableView registerNib:[UINib nibWithNibName:@"StoriesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
}

#pragma mark - Table View DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.storiesModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[StoriesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.titleLabel.text = self.storiesModelArray[indexPath.row].title;
        
    }
        return cell;
}


#pragma mark - Table View Delegate


#pragma mark - 解析TopStories 和Stories
- (void)serilizeTopStories:(NSArray *)array{
    NSMutableArray *topStoiresArray = [NSMutableArray array];
    for (NSDictionary *topStory in array) {
        TopstoriesModel *model = [[TopstoriesModel alloc]init];
        model.image = topStory[@"image"];
        model.title = topStory[@"title"];
        model.topStoriesid = topStory[@"id"];
        [topStoiresArray addObject:model];
    }
    TopstoriesModel *firstTopStory = [topStoiresArray firstObject];
    TopstoriesModel *lastTopStroy = [topStoiresArray lastObject];
    [topStoiresArray insertObject:lastTopStroy atIndex:0];
    [topStoiresArray addObject:firstTopStory];
    self.topStoiresModelArray = [topStoiresArray copy];
    
    [scrollView setTopStories:self.topStoiresModelArray];
}

- (NSArray *)serilizeStories:(NSArray *)array{
    NSMutableArray *stoiresArray = [NSMutableArray array];
    for (NSDictionary *story in array) {
        StoriesModel *model = [[StoriesModel alloc]init];
        model.images = story[@"images"];
        model.storyID = story[@"id"];
        model.title = story[@"title"];
        [stoiresArray addObject:model];
    }
    self.storiesModelArray = [stoiresArray copy];
    return self.storiesModelArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
