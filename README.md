# LBUnderlineSegmentedControl
```objc
LBUnderlineSegmentedControl *segmentedControl = [[LBUnderlineSegmentedControl alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 60) items:@[@"大象",@"美洲豹",@"河马",@"齐天大圣"] action:^(UIButton *__weak  _Nonnull sliderButton, BOOL isSet) {
    
}];
segmentedControl.textColor = [UIColor blackColor];
segmentedControl.selectedTextColor = [UIColor blueColor];
segmentedControl.underlineColor = [UIColor magentaColor];
segmentedControl.underlineWidth = 20;
[segmentedControl setNews:YES forSegmentIndex:2];
```
![](https://github.com/A1129434577/LBUnderlineSegmentedControl/blob/master/LBUnderlineSegmentedControl.gif?raw=true)
