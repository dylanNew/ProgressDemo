//
//  ProgressView.h
//  ProgressDemo
//
//  Created by myname on 14-9-11.
//  Copyright (c) 2014年 myname. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

- (void)setPercent:(float)percent animated:(BOOL)anmated;




+ (void)setProgressLineWidth:(CGFloat)width;

@end
