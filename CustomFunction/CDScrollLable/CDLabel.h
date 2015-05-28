//
//  CDLabel.h
//  CustomFunction
//
//  Created by Chendi on 15/5/28.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDLabel : UIView

@property (nonatomic, retain) NSString *cdText;
@property (nonatomic, retain) UIFont *cdFont;
@property (nonatomic, retain) UIColor *cdTextColor;

@property (nonatomic)BOOL  enableScrollDispaly;

- (void)restartScroll;
- (void)stopScroll;
@end
