//
//  FYYCategory.h
//  美团
//
//  Created by 冯钰洋 on 16/3/9.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYYCategory : NSObject
/**
 *  类别名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  子类别的名称
 */
@property (nonatomic, strong) NSArray *subcategories;
/**
 *  下拉菜单中的小图标
 */
@property (nonatomic, copy) NSString *small_highlighted_icon;
@property (nonatomic, copy) NSString *small_icon;
/**
 *  显示在导航栏顶部的大图标
 */
@property (nonatomic, copy) NSString *highlighted_icon;
@property (nonatomic, copy) NSString *icon;
/**
 *  显示在地图上的图标
 */
@property (nonatomic, copy) NSString *map_icon;
@end
