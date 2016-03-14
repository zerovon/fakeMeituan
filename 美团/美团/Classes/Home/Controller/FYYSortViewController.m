//
//  FYYSortViewController.m
//  美团
//
//  Created by 冯钰洋 on 16/3/13.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYSortViewController.h"
#import "FYYMetaUtil.h"
#import "FYYSort.h"
#import "UIView+Extension.h"
#import "FYYConst.h"

@interface FYYSortViewController ()

@end

@implementation FYYSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *sorts = [FYYMetaUtil sorts];
    NSUInteger count = sorts.count;
    CGFloat btnW = 100;
    CGFloat btnH = 30;
    CGFloat btnX = 15;
    CGFloat btnStart = 15;
    CGFloat padding = 15;
    CGFloat height = 0;
    for (NSUInteger i = 0; i < count; i++) {
        FYYSort *sort = sorts[i];
        
        UIButton *button = [[UIButton alloc] init];
        button.width = btnW;
        button.height = btnH;
        button.x = btnX;
        button.y = btnStart + (btnH + padding) *i;
        [button setTitle:sort.label forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        height = CGRectGetMaxY(button.frame);
        [self.view addSubview:button];
    }
    
    //设置控制器在popover中的尺寸
    CGFloat width = btnW +2 * btnX;
    height += padding;
    self.preferredContentSize = CGSizeMake(width, height);
}

- (void)buttonClick: (UIButton *)button
{
    [FYYNotificationCenter postNotificationName:FYYSortDidChageNotification object:nil userInfo:@{FYYSelectSort : [FYYMetaUtil sorts][button.tag]}];
}


@end
