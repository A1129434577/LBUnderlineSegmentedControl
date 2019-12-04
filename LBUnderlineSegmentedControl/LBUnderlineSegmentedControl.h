//
//  TitleSwitchView.h
//  operator
//
//  Created by 刘彬 on 2019/1/11.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBUnderlineSegmentedControl : UIView
@property (nonatomic,strong,readonly)UIButton *sliderButton;
@property (nonatomic,strong,readonly)NSArray<UIButton *> *itemsBtnArray;
@property (nonatomic,strong)UIFont  *font;//default[UIFont systemFontOfSize:14]
@property (nonatomic,strong)UIColor *textColor;
@property (nonatomic,strong)UIColor *selectedTextColor;
@property (nonatomic,assign)CGFloat underlineSpacing;//default 0.f
@property (nonatomic,assign)CGFloat underlineHeight;//default 2.0f
@property (nonatomic,assign)CGFloat underlineWidth;//default 0.0f,根据sliderButton的title自适应长短，如果设值，将利用设值
@property (nonatomic,strong)UIColor *underlineColor;//如果不定义，将取selectedTextColor
@property (nonatomic,strong)UIColor *newsPointColor;//default [UIColor redColor]
@property (nonatomic,assign)CGFloat newsPointSide;//default 6.f

@property (nonatomic,assign)NSInteger selectedSegmentIndex;
@property (nonatomic,assign)BOOL sliderButtonAnimated;//标题动画default NO
@property (nonatomic,assign)BOOL dampingAnimated;//弹簧动画default NO

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *>*)items action:(void (^ _Nullable)(__weak UIButton *sliderButton,BOOL isSet))action;//isSet代表手动设置切换而非点击切换itme的
-(void)setNews:(BOOL)showNews forSegmentIndex:(NSInteger)selectedSegmentIndex;
@end

NS_ASSUME_NONNULL_END
