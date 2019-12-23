//
//  TitleSwitchView.m
//  operator
//
//  Created by 刘彬 on 2019/1/11.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "LBUnderlineSegmentedControl.h"

@interface LBUnderlineSegmentedButton : UIButton
@property (nonatomic,strong)UIView *newsPointView;
@property (nonatomic,assign)CGFloat lineSpacing;
@property (nonatomic,assign)CGFloat lineHeight;
@property (nonatomic,assign)CGFloat lineWidth;//default 0.0f,根据title自适应长短，如果设值，将利用设值
@property (nonatomic,strong)UIView *underlineView;
@end
@implementation LBUnderlineSegmentedButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _newsPointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
        _newsPointView.layer.cornerRadius = CGRectGetHeight(_newsPointView.frame)/2;
        _newsPointView.backgroundColor = [UIColor redColor];
        _newsPointView.clipsToBounds = YES;
        _newsPointView.hidden = YES;
        [self addSubview:_newsPointView];
        
        [self.titleLabel addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionNew context:nil];
        
        _underlineView = [[UIView alloc] init];
        [self addSubview:_underlineView];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isEqual:self.titleLabel] && [keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
        _newsPointView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame)-CGRectGetWidth(_newsPointView.frame)/2, CGRectGetMinY(self.titleLabel.frame)-CGRectGetHeight(_newsPointView.frame)/2, CGRectGetWidth(_newsPointView.frame), CGRectGetHeight(_newsPointView.frame));
        
        if (!_underlineView.superview || _underlineView.superview == self) {
            CGFloat underlineWidth = (_lineWidth>0)?_lineWidth:CGRectGetWidth(self.titleLabel.frame);
            _underlineView.frame = CGRectMake(self.titleLabel.center.x-underlineWidth/2, CGRectGetMaxY(self.titleLabel.frame)+_lineSpacing, underlineWidth, _lineHeight);
        }
        
    }
}

-(void)setLineHeight:(CGFloat)lineHeight{
    _lineHeight = lineHeight;
    [self observeValueForKeyPath:NSStringFromSelector(@selector(frame)) ofObject:self.titleLabel change:nil context:nil];
}
-(void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    [self observeValueForKeyPath:NSStringFromSelector(@selector(frame)) ofObject:self.titleLabel change:nil context:nil];
}
-(void)setLineSpacing:(CGFloat)lineSpacing{
    _lineSpacing = lineSpacing;
    [self observeValueForKeyPath:NSStringFromSelector(@selector(frame)) ofObject:self.titleLabel change:nil context:nil];
}

-(void)dealloc{
    [self.titleLabel removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame))];
}
@end


@interface LBUnderlineSegmentedControl ()
@property (nonatomic,strong)NSMutableArray<LBUnderlineSegmentedButton *> *privateItemsBtnArray;
@property (nonatomic,copy)void (^itemSeletedBlock)(__weak UIButton *sliderButton,BOOL isTopAction);
@end
@implementation LBUnderlineSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray <NSString *>*)items action:(void (^ _Nullable)(__weak UIButton *sliderButton,BOOL isSet))action
{
    self = [super initWithFrame:frame];
    if (self) {
        _privateItemsBtnArray = [NSMutableArray array];
        _itemSeletedBlock = action;
        
        typeof(self) __weak weakSelf = self;
        typeof(items) __weak weakItems = items;
        [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LBUnderlineSegmentedButton *itemsBtn = [[LBUnderlineSegmentedButton alloc] initWithFrame:CGRectMake(idx*(CGRectGetWidth(frame)/weakItems.count), 0, CGRectGetWidth(frame)/weakItems.count, CGRectGetHeight(frame))];
            itemsBtn.underlineView.hidden = YES;
            [itemsBtn setTitle:obj forState:UIControlStateNormal];
            [itemsBtn addTarget:weakSelf action:@selector(itemSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
            [weakSelf addSubview:itemsBtn];
            [weakSelf.privateItemsBtnArray addObject:itemsBtn];
        }];
        _itemsBtnArray = [NSArray arrayWithArray:_privateItemsBtnArray];
        
        _sliderButton = [[LBUnderlineSegmentedButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame)/items.count, CGRectGetHeight(frame))];
        _sliderButton.userInteractionEnabled = NO;
        [self addSubview:_sliderButton];
        
        self.font = [UIFont systemFontOfSize:16];
        self.backgroundColor = [UIColor whiteColor];
        self.underlineHeight = 2;
        self.textColor = [UIColor darkGrayColor];
        self.selectedTextColor = [UIColor blackColor];

        
        [self setSelectedSegmentIndex:0];
    }
    return self;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    _sliderButton.backgroundColor = self.backgroundColor;
}

-(void)setUnderlineHeight:(CGFloat)underlineHeight{
    _underlineHeight = underlineHeight;
    [(LBUnderlineSegmentedButton *)_sliderButton setLineHeight:underlineHeight];
}
-(void)setUnderlineWidth:(CGFloat)underlineWidth{
    _underlineWidth = underlineWidth;
    [(LBUnderlineSegmentedButton *)_sliderButton setLineWidth:underlineWidth];
}
-(void)setUnderlineSpacing:(CGFloat)underlineSpacing{
    _underlineSpacing = underlineSpacing;
    [(LBUnderlineSegmentedButton *)_sliderButton setLineSpacing:underlineSpacing];
}

-(void)setUnderlineColor:(UIColor *)underlineColor{
    _underlineColor = underlineColor;
    ((LBUnderlineSegmentedButton *)_sliderButton).underlineView.backgroundColor = underlineColor;
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [_privateItemsBtnArray enumerateObjectsUsingBlock:^(LBUnderlineSegmentedButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitleColor:textColor forState:UIControlStateNormal];
    }];
}
-(void)setSelectedTextColor:(UIColor *)selectedTextColor{
    _selectedTextColor = selectedTextColor;
    [_sliderButton setTitleColor:selectedTextColor forState:UIControlStateNormal];
    if (!_underlineColor) {
        self.underlineColor = selectedTextColor;
    }
}
-(void)setFont:(UIFont *)font{
    _font = font;
    [_privateItemsBtnArray enumerateObjectsUsingBlock:^(LBUnderlineSegmentedButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleLabel.font = font;
    }];
    _sliderButton.titleLabel.font = font;
}
-(void)setNewsPointColor:(UIColor *)newsPointColor{
    _newsPointColor = newsPointColor;
    [_privateItemsBtnArray enumerateObjectsUsingBlock:^(LBUnderlineSegmentedButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.newsPointView.backgroundColor = newsPointColor;
    }];
    ((LBUnderlineSegmentedButton *)_sliderButton).newsPointView.backgroundColor = newsPointColor;
}

-(void)setNewsPointSide:(CGFloat)newsPointSide{
    _newsPointSide = newsPointSide;
    [_privateItemsBtnArray enumerateObjectsUsingBlock:^(LBUnderlineSegmentedButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.newsPointView.bounds = CGRectMake(0, 0, newsPointSide, newsPointSide);
        [obj observeValueForKeyPath:NSStringFromSelector(@selector(frame)) ofObject:obj.titleLabel change:nil context:nil];
        obj.newsPointView.layer.cornerRadius = CGRectGetHeight(obj.newsPointView.bounds)/2;
    }];
    LBUnderlineSegmentedButton *sliderButton = ((LBUnderlineSegmentedButton *)_sliderButton);
    sliderButton.newsPointView.bounds = CGRectMake(0, 0, newsPointSide, newsPointSide);
    [sliderButton observeValueForKeyPath:NSStringFromSelector(@selector(frame)) ofObject:sliderButton.titleLabel change:nil context:nil];
    sliderButton.newsPointView.layer.cornerRadius = CGRectGetHeight(sliderButton.newsPointView.bounds)/2;
}


-(void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex{
    _selectedSegmentIndex = selectedSegmentIndex;
    
    [self selectSegmentIndex:selectedSegmentIndex];
    
    typeof(self) __weak weakSelf = self;
    self.itemSeletedBlock?
    self.itemSeletedBlock(weakSelf.sliderButton,YES):NULL;
}
-(void)setNews:(BOOL)showNews forSegmentIndex:(NSInteger)selectedSegmentIndex{
    [_privateItemsBtnArray objectAtIndex:selectedSegmentIndex].newsPointView.hidden = !showNews;
}

-(void)itemSelectedAction:(LBUnderlineSegmentedButton *)sender{
    [self selectSegmentIndex:[_privateItemsBtnArray indexOfObject:sender]];
    
    typeof(self) __weak weakSelf = self;
    self.itemSeletedBlock?
    self.itemSeletedBlock(weakSelf.sliderButton,NO):NULL;
}

-(void)selectSegmentIndex:(NSInteger)selectedSegmentIndex{
    LBUnderlineSegmentedButton *itmeBtn = [self.privateItemsBtnArray objectAtIndex:selectedSegmentIndex];
    [self.sliderButton setTitle:[itmeBtn currentTitle] forState:UIControlStateNormal];
    
    typeof(self) __weak weakSelf = self;
    if (self.sliderButtonAnimated) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:_dampingAnimated?0.6:1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakSelf.sliderButton.center = CGPointMake(itmeBtn.center.x, weakSelf.sliderButton.center.y);
            ((LBUnderlineSegmentedButton *)weakSelf.sliderButton).newsPointView.hidden = itmeBtn.newsPointView.hidden;
        } completion:NULL];
    }else{
        UIView *underlineView = ((LBUnderlineSegmentedButton *)_sliderButton).underlineView;
        CGRect underlineFrameInSliderButton = underlineView.frame;
        CGRect underlineFrameInSelf = [self convertRect:underlineFrameInSliderButton fromView:_sliderButton];
        underlineView.frame = underlineFrameInSelf;
        [self addSubview:underlineView];
        
        self.sliderButton.center = CGPointMake(itmeBtn.center.x, self.sliderButton.center.y);
        
        CGRect underlineNewFrameInSelf = [self convertRect:underlineFrameInSliderButton fromView:self.sliderButton];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:_dampingAnimated?0.6:1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            underlineView.frame = underlineNewFrameInSelf;
            ((LBUnderlineSegmentedButton *)weakSelf.sliderButton).newsPointView.hidden = itmeBtn.newsPointView.hidden;
        } completion:^(BOOL finished) {
            underlineView.frame = underlineFrameInSliderButton;
            [weakSelf.sliderButton addSubview:underlineView];
        }];
    }
    
}

@end
