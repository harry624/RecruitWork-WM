//
//  MainViewController.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "MainViewController.h"
#import "NetManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLatestNews];
    [self initsubViews];
}

- (void)getLatestNews{
    [NetManager getLatestNewsWithsuccess:^(id JSON) {
    
    }];
}

- (void)initsubViews{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
