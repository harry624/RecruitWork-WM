//
//  ViewController.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolKit.h"
#import "LeftMenuViewController.h"
#import "MainViewController.h"


@interface ViewController : UIViewController

- (instancetype)initWithLeftMenu:(LeftMenuViewController *)leftMenuController
                        MainPage:(MainViewController *)mainPageController;

- (void)showLeftMenu;

@end

