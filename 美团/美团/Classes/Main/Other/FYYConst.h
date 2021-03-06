//
//  FYYConst.h
//  美团
//
//  Created by 冯钰洋 on 16/3/8.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FYYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define FYYGlobalBg FYYColor(230, 230, 230)

#define FYYNotificationCenter [NSNotificationCenter defaultCenter]

extern NSString *const FYYCityDidSelectNotification;
extern NSString *const FYYSelectCityName;

extern NSString *const FYYSortDidChageNotification;
extern NSString *const FYYSelectSort;

extern NSString *const FYYCategoryDidChageNotification;
extern NSString *const FYYSelectCategory;
extern NSString *const FYYSelectSubCategory;

extern NSString *const FYYDistrictDidChageNotification;
extern NSString *const FYYSelectDistrict;
extern NSString *const FYYSelectSubDistrict;
