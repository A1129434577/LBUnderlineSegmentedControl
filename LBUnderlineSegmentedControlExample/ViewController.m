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
    LBUnderlineSegmentedControl *segmentedControl = [[LBUnderlineSegmentedControl alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 60) items:@[@"大象",@"美洲豹",@"河马",@"齐天大圣"] action:^(UIButton *__weak  _Nonnull sliderButton, BOOL isSet) {
        
    }];
    segmentedControl.underlineWidth = 20;
    [self.view addSubview:segmentedControl];
}

@end
