//
//  ViewController.m
//  LBTextFieldDemo
//
//  Created by 刘彬 on 2019/9/24.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "LBUnderlineSegmentedControl.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"LBUnderlineSegmentedControl";
    LBUnderlineSegmentedControl *segmentedControl = [[LBUnderlineSegmentedControl alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 60) items:@[@"关注",@"热门话题",@"附近"] action:^(UIButton *__weak  _Nonnull sliderButton, BOOL isSet) {
    }];
//    segmentedControl.sliderButtonAnimated = NO;
//    segmentedControl.dampingAnimated = NO;
    segmentedControl.textColor = [UIColor blackColor];
    segmentedControl.selectedTextColor = [UIColor blueColor];
    segmentedControl.font = [UIFont systemFontOfSize:15];
    segmentedControl.sliderButton.titleLabel.font = [UIFont systemFontOfSize:18];
    segmentedControl.underlineSpacing = 5;
    segmentedControl.underlineHeight = 2.5;
    segmentedControl.underlineWidth = 40;
    segmentedControl.underlineColor = [UIColor magentaColor];
    [self.view addSubview:segmentedControl];
}

@end
