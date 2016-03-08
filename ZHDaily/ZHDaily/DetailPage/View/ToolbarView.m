//
//  ToobarView.m
//  ZHDaily
//
//  Created by 王豪 on 16/3/8.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "ToolbarView.h"

@implementation ToolbarView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, kScreenHeight - 44.f, kScreenWidth, 44.f)];
    if (self) {
        [self configureToolBarButton];
        [self configureline];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)configureToolBarButton{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth/5, 43)];
    [backButton setImage:[UIImage imageNamed:@"News_Navigation_Arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    NSLog(@"back:%f",backButton.frame.origin.x);
    
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/5, 1, kScreenWidth/5, 43)];
    [backButton setImage:[UIImage imageNamed:@"News_Navigation_Next"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextButton];
    NSLog(@"next:%f",nextButton.frame.origin.x);

    UIButton *votedButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/5) *2.f, 1, kScreenWidth/5, 43)];
    [backButton setImage:[UIImage imageNamed:@"News_Navigation_Voted"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(voted:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:votedButton];
    NSLog(@"vote:%f",votedButton.frame.origin.x);

    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/5) *3, 1, kScreenWidth/5, 43)];
    [backButton setImage:[UIImage imageNamed:@"News_Navigation_Share"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shareButton];
    NSLog(@"share:%f",shareButton.frame.origin.x);

    UIButton *commentButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth/5) *4, 1, kScreenWidth/5, 43)];
    [backButton setImage:[UIImage imageNamed:@"News_Navigation_Comment"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commentButton];
    NSLog(@"comment:%f",commentButton.frame.origin.x);

}

- (void)configureline{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    label.text = @"";
    label.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:label];
}
#pragma mark - Action
- (void)back:(id)sender{
    [self.delegate backAction:sender];
}

- (void)next:(id)sender{
    [self.delegate nextAction:sender];
}

- (void)voted:(id)sender{
    [self.delegate votedAction:sender];
}

- (void)share:(id)sender{
    [self.delegate shareAction:sender];
}

- (void)comment:(id)sender{
    [self.delegate commentAction:sender];
}
@end
