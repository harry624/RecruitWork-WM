//
//  ViewController.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "ViewController.h"
#import "ToolKit.h"

#define AnimationDuration           0.2
#define MainViewOriginXFromValue    0
#define MainViewOriginXEndValue     kScreenWidth*0.6
#define LeftViewOriginXFromValue    -kScreenWidth* 0.6
#define LeftViewOriginXEndValue     0

@interface ViewController ()
@property (nonatomic, strong) LeftMenuViewController *leftMenuController;
@property (nonatomic, strong) MainViewController *mainController;
@property (nonatomic, strong) UIView *leftMenuView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@end

@implementation ViewController

- (instancetype)initWithLeftMenu:(LeftMenuViewController *)leftMenuController
                        MainPage:(MainViewController *)mainPageController{
    if (self = [super init]) {
        self.mainController = mainPageController;
        self.leftMenuController = leftMenuController;
    }
    return self;
}

- (void)viewDidLoad{
    _distance = MainViewOriginXFromValue;
    _leftMenuView = _leftMenuController.view;
    _leftMenuView.frame = kScreenBounds;

    [self.view addSubview:_leftMenuView];
    
    _mainView = [[UIView alloc]initWithFrame:kScreenBounds];
    [self.view addSubview:_mainView];
    [_mainView addSubview:_mainController.view];
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:_panGesture];
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
}


- (void)panAction:(UIPanGestureRecognizer *)panRecogizer{
    CGFloat moveX = [panRecogizer translationInView:self.view].x;
    CGFloat totalDistance = _distance + moveX;
    
    if (totalDistance > 0 && totalDistance < MainViewOriginXEndValue) {
        _leftMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, LeftViewOriginXFromValue + totalDistance, 0);
        _mainView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXFromValue + totalDistance, 0);
    }
    if (panRecogizer.state == UIGestureRecognizerStateEnded) {
        if (totalDistance <= MainViewOriginXEndValue / 3) {
            [self hideLeftMenu];
        }else{
            [self showLeftMenu];
        }
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapRecognizer{
    [self hideLeftMenu];
}

- (void)showLeftMenu{
    [UIView animateWithDuration:AnimationDuration animations:^{
        _mainView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXEndValue, 0);
        _leftMenuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _distance = MainViewOriginXEndValue;
        [_mainView addGestureRecognizer:_tapGesture];
    }];
}

- (void)hideLeftMenu{
    [UIView animateWithDuration:AnimationDuration animations:^{
        _mainView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, MainViewOriginXFromValue, 0);
        _leftMenuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _distance = MainViewOriginXFromValue;
        [_mainView removeGestureRecognizer:_tapGesture];
    }];
}
@end
