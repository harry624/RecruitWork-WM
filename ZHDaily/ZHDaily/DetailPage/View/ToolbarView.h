//
//  ToobarView.h
//  ZHDaily
//
//  Created by 王豪 on 16/3/8.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolKit.h"

@protocol ToolBarDelegate <NSObject>

-(void)backAction:(id)sender;
-(void)nextAction:(id)sender;
-(void)votedAction:(id)sender;
-(void)shareAction:(id)sender;
-(void)commentAction:(id)sender;


@end

@interface ToolbarView : UIView
@property(nonatomic)id<ToolBarDelegate> delegate;

@end
