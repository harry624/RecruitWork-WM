//
//  MainViewController.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainPageViewModel.h"

@interface MainViewController : UIViewController

- (instancetype)initWithViewModel:(MainPageViewModel *)viewModel;

@end
