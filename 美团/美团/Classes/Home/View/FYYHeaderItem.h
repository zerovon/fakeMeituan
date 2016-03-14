//
//  FYYHeaderItem.h
//  美团
//
//  Created by 冯钰洋 on 16/3/8.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYYHeaderItem : UIView

+ (instancetype)item;

/**
 *  设置监听器
 *
 *  @param target 监听器
 *  @param action 监听方法
 */
- (void) addTarget:(id)target action:(SEL)action;


- (void)setTitle:(NSString *)title;
- (void)setSubTitle:(NSString *)subTitle;
- (void)setIcon:(NSString *)icon highLightIcon:(NSString *)hIon;

@end
