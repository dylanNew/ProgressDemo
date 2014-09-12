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
@property (nonatomic, strong) UILabel *prencetLabel;

@end

@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self layoutAnimatedLayer];
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
    gradientLayer1.frame = CGRectMake(0, 0, width/2, hegith);
    gradientLayer1.colors = @[(id)[[UIColor redColor] CGColor],(id)[[UIColor yellowColor] CGColor]];
    gradientLayer1.locations = @[@0.5,@0.9,@1];
    gradientLayer1.startPoint = CGPointMake(0.5, 1);
    gradientLayer1.endPoint = CGPointMake(0.5, 0);
    [gradientLayer addSublayer:gradientLayer1];
    
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = CGRectMake(width/2, 0, width/2, hegith);
    gradientLayer2.colors = @[(id)[[UIColor blueColor] CGColor],(id)[[UIColor yellowColor] CGColor]];
    gradientLayer2.locations = @[@0.1,@0.9,@1];
    gradientLayer2.startPoint = CGPointMake(0.5, 1);
    gradientLayer2.endPoint = CGPointMake(0.5, 0);
    [gradientLayer addSublayer:gradientLayer2];
    
    gradientLayer.mask = self.progressLayer;
    [self.layer addSublayer:gradientLayer];
    
    self.prencetLabel = [[UILabel alloc] init];
    [self.prencetLabel setBackgroundColor:[UIColor redColor]];
    [self.prencetLabel setTextAlignment:NSTextAlignmentCenter];
    self.prencetLabel.center = CGPointMake(width/2, hegith/2);
    [self addSubview:self.prencetLabel];
}

- (void)setPercent:(float)percent animated:(BOOL)animated
{
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
    self.progressLayer.strokeEnd = percent;
    [CATransaction commit];
    
    self.prencetLabel.text = [NSString stringWithFormat:@"%.2f%%",percent * 100];
    [self.prencetLabel sizeToFit];
    self.prencetLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

#pragma mark - 
+ (void)setProgressLineWidth:(CGFloat)width
{
    progressLineWidth = width;
}


@end
