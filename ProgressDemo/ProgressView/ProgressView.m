//
//  ProgressView.m
//  ProgressDemo
//
//  Created by myname on 14-9-11.
//  Copyright (c) 2014年 myname. All rights reserved.
//

#import "ProgressView.h"

static CGFloat progressLineWidth = 4;

@interface ProgressView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end

@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)layoutAnimatedLayer
{
    CGFloat width = self.frame.size.width;
    CGFloat hegith = self.frame.size.height;
    //构造园线
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2, hegith/2) radius:(width - progressLineWidth)/2 startAngle:-M_PI*7/6 endAngle:M_PI/6 clockwise:YES];
    
    //一个背景的layer
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = self.bounds;
    trackLayer.fillColor = [[UIColor clearColor] CGColor];
    trackLayer.strokeColor = [[UIColor whiteColor] CGColor];//背景的颜色，可以设置成属性
    trackLayer.opacity = 0.25;
    trackLayer.lineCap = kCALineCapRound;
    trackLayer.lineWidth = progressLineWidth;
    trackLayer.path = [path CGPath];
    [self.layer addSublayer:trackLayer];
    //用于截取显示层的layer，其大小与背景层的相同 最终是通过strokeEnd 设置百分比
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor = [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor = [[UIColor whiteColor] CGColor];//背景的颜色，可以设置成属性
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = progressLineWidth;
    self.progressLayer.path = [path CGPath];
    
    //一个渐变的
    CALayer *gradientLayer = [CALayer layer];
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
//    gradientLayer1.frame = CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
    
    
}

#pragma mark - 
+ (void)setProgressLineWidth:(CGFloat)width
{
    progressLineWidth = width;
}

@end
