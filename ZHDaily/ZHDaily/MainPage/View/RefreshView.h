//
//  RefreshView.h
//  ZHDaily
//
//  Created by 王豪 on 16/2/24.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView

- (void)RedrawFromProgress:(CGFloat)progress;
- (void)startAnimation;
- (void)stopAnimation;
@end
