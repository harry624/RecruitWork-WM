//
//  AppDelegate.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/17.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ToolKit.h"
#import "NetManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface AppDelegate ()
@property (nonatomic, strong) UIView *launchScreenView;
@property (nonatomic, strong) UIImageView *logoImage;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:kScreenBounds];
    MainViewController *controller = [[MainViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    [self setupLaunchPic];
    
    return YES;
}

- (void)setupLaunchPic{
    _launchScreenView = [[UIView alloc]initWithFrame:kScreenBounds];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:kScreenBounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 2 - 100, kScreenHeight - 40, 200, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    
    [self.launchScreenView addSubview:imageView];
    [self.launchScreenView addSubview:label];
    [self.window addSubview:_launchScreenView];
    
    _logoImage = [[UIImageView alloc]initWithFrame:kScreenBounds];
    _logoImage.image = [UIImage imageNamed:@"Default"];
    _logoImage.contentMode = UIViewContentModeScaleAspectFill;
    [self.window addSubview:_logoImage];
    
    [NetManager getLaunchImageWithsize:@"720*1184" success:^(id JSON) {
        NSString *imageURL = JSON[@"img"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil];
        label.text = JSON[@"text"];
    }];
    
    [UIView animateWithDuration:4 animations:^{
        self.logoImage.alpha = 0;
        imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [self.logoImage removeFromSuperview];
        [self.launchScreenView removeFromSuperview];
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
