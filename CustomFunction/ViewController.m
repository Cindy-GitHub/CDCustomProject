//
//  ViewController.m
//  CustomFunction
//
//  Created by Chendi on 15/5/28.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "ViewController.h"
#import "CDLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CDLabel *label = [[CDLabel alloc] init];
    label.backgroundColor = [UIColor yellowColor];
    label.cdText = @"我测试数据在滚动的";
    [self.view addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@60.0);
        make.height.equalTo(@50.0);
        make.centerX.equalTo(self.view.centerX);
        make.centerY.equalTo(self.view.centerY);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
