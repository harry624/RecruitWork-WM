//
//  RefreshView.m
//  ZHDaily
//
//  Created by 王豪 on 16/2/24.
//  Copyright © 2016年 hao. All rights reserved.
//

#import "RefreshView.h"


@interface RefreshView ()
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) CAShapeLayer *whiteCircleLayer;
@property (nonatomic, strong) CAShapeLayer *grayCircleLayer;

@end

@implementation RefreshView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_indicatorView];
        
        CGFloat radius = MIN(frame.size.width, frame.size.height)/2 - 3;
        _grayCircleLayer = [[CAShapeLayer alloc]init];
        _grayCircleLayer.lineWidth = 0.5f;
        _grayCircleLayer.strokeColor = [UIColor grayColor].CGColor;
        _grayCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _grayCircleLayer.opacity = 0.f;
        _grayCircleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(frame.size.width/2-radius, frame.size.height/2-radius, 2*radius, 2*radius)].CGPath;
        [self.layer addSublayer:_grayCircleLayer];
        
        _whiteCircleLayer = [[CAShapeLayer alloc]init];
        _whiteCircleLayer.lineWidth = 1.0f;
        _whiteCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
        _whiteCircleLayer.fillColor = [UIColor clearColor].CGColor;
        _whiteCircleLayer.strokeEnd = 0.f;
        _whiteCircleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height /2 ) radius:radius startAngle:M_PI_2 endAngle:M_PI * 5/2 clockwise:YES].CGPath;
        [self.layer addSublayer:_whiteCircleLayer];
    }
    return self;
}

- (void)RedrawFromProgress:(CGFloat)progress{
    if (progress > 0) {
        _whiteCircleLayer.opacity = 1.f;
        _grayCircleLayer.opacity = 1.f;
        _whiteCircleLayer.strokeEnd = progress;
        if (progress == 1) {
            _whiteCircleLayer.opacity = 0.f;
            _grayCircleLayer.opacity = 0.f;
        }
    }else if (progress <= 0){
        _whiteCircleLayer.opacity = 0.f;
        _grayCircleLayer.opacity = 0.f;
    }
}
- (void)startAnimation{
    [_indicatorView startAnimating];
}
- (void)stopAnimation{
    [_indicatorView stopAnimating];
}

@end
