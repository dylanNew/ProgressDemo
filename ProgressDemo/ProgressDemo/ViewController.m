//
//  ViewController.m
//  ProgressDemo
//
//  Created by myname on 14-9-11.
//  Copyright (c) 2014年 myname. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"

@interface ViewController ()
{
    ProgressView *progressView;
    NSTimer *timer;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    progressView = [[ProgressView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
    [progressView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:progressView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.9 target:self selector:@selector(change:) userInfo:nil repeats:YES];
}

- (void)change:(id)sender
{
    int p = arc4random() %100;
    NSLog(@"%i",p);
    [progressView setPercent:p/100.0 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
