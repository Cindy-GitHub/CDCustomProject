//
//  CDLabel.m
//  CustomFunction
//
//  Created by Chendi on 15/5/28.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "CDLabel.h"

enum ScrollOrientation {
    LeftOrientation = 1,
    RightOrientation
};

const CGFloat  intervalValue  = 10.0;

@interface CDLabel()
{
    UILabel *_label;
    UIScrollView *_scrollView;
  
    dispatch_source_t  _scrollTimer;
    enum ScrollOrientation  _scrollOrientation;
    BOOL  _continueScroll;
}
@end
@implementation CDLabel

#pragma mark - init method
- ( void)awakeFromNib
{
    [self initSubview];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubview];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)initSubview
{
    if (_label == nil && _scrollView == nil) {
        _label = [[UILabel alloc] init];
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        
        [_scrollView addSubview:_label];
        [self addSubview:_scrollView];
    }
    [self restartScroll];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self adjustSubviewConstraint];
}

#pragma mark - setter method
-(void)setCdText:(NSString *)cdText
{
    _label.text = cdText;
    _cdText = cdText;
    _scrollOrientation = RightOrientation;
    [self adjustSubviewConstraint];
    [self restartScroll];
}

- (void)setCdTextColor:(UIColor *)cdTextColor
{
    _label.textColor = cdTextColor;
    _cdTextColor = cdTextColor;
    [self adjustSubviewConstraint];
}

- (void)setCdFont:(UIFont *)cdFont
{
    _label.font = cdFont;
    _cdFont = cdFont;
    [self adjustSubviewConstraint];
}

- (void)setEnableScrollDispaly:(BOOL)enableScrollDispaly
{
    _continueScroll = enableScrollDispaly;
    _enableScrollDispaly = enableScrollDispaly;
}

#pragma mark - adjust constraint
- (void)adjustSubviewConstraint
{
    [_scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top);
        make.left.equalTo(self.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
    }];
    
    CGSize labelSize = [_label.text sizeWithAttributes:@{NSForegroundColorAttributeName: _label.textColor , NSFontAttributeName: _label.font}];
    _label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    
    CGSize contentSize = CGSizeMake(labelSize.width + intervalValue, 0.0);
    _scrollView.contentSize = contentSize;
}

#pragma mark -
- (void)restartScroll
{
    if (_scrollTimer) {
        dispatch_source_cancel(_scrollTimer);
    }
    _scrollTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(_scrollTimer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), (int64_t)(0.2f * NSEC_PER_SEC), 0);
    dispatch_source_set_event_handler(_scrollTimer, ^{
        dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), ^{
            
            CGFloat  offsetX = _scrollView.contentOffset.x;
            if ( offsetX <= 0) {
                _scrollOrientation = RightOrientation;
            } else if (offsetX >= _scrollView.contentSize.width - _scrollView.frame.size.width - intervalValue/2.0) {
                 _scrollOrientation = LeftOrientation;
                dispatch_source_cancel(_scrollTimer);
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(restartScroll) userInfo:nil repeats:NO];
            }

            [UIView animateWithDuration:0.2f animations:^{
//                if (_scrollOrientation == LeftOrientation) {
//                    _scrollView.contentOffset = CGPointMake(offsetX - 2.0 , 0.0);
//                } else if (_scrollOrientation == RightOrientation) {
                    _scrollView.contentOffset = CGPointMake(offsetX + 2.0 , 0.0);
//                }
            }];
           
            
        });
    });
    
    dispatch_source_set_cancel_handler(_scrollTimer, ^{
        _scrollView.contentOffset = CGPointMake( 0.0, 0.0);
    });
    
    //   启动
    dispatch_resume(_scrollTimer);
}

- (void)stopScroll
{
    if (_scrollTimer) {
        dispatch_source_cancel(_scrollTimer);
    }
}


@end
