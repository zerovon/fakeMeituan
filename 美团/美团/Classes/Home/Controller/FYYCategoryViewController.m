//
//  FYYCategoryViewController.m
//  美团
//
//  Created by 冯钰洋 on 16/3/9.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYCategoryViewController.h"
#import "FYYHomeDropDown.h"
#import "FYYCategory.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "FYYMetaUtil.h"
#import "FYYConst.h"

@interface FYYCategoryViewController () <FYYHomeDropDownDataSource, FYYHomeDropDownDelegate>

@end

@implementation FYYCategoryViewController

- (void)loadView {
    FYYHomeDropDown *categoryDown = [FYYHomeDropDown dropDown];
    
//    categoryDown.categories = [FYYCategory objectArrayWithFilename:@"categories.plist"];
    categoryDown.dataSource = self;
    categoryDown.delegate = self;
    self.view = categoryDown;
    
//    [self.view addSubview:categoryDown];
    
    //设置控制器view在popover中的尺寸
    self.preferredContentSize = categoryDown.size;
}

#pragma mark - 下拉菜单数据源方法
- (NSString *)homeDropdown:(FYYHomeDropDown *)dropDown titleForRowInMainTable:(int)row
{
    FYYCategory * cat =  [FYYMetaUtil categories][row];
    return  cat.name;
}

- (NSString *)homeDropdown:(FYYHomeDropDown *)dropDown iconForRowInMainTable:(int)row
{
    FYYCategory * cat =  [FYYMetaUtil categories][row];
    return cat.small_icon;
}

- (NSString *)homeDropdown:(FYYHomeDropDown *)dropDown highIconForRowInMainTable:(int)row
{
    FYYCategory * cat =  [FYYMetaUtil categories][row];
    return cat.small_highlighted_icon;
}

- (NSArray *)homeDropdown:(FYYHomeDropDown *)dropDown subDataForRowInMainTable:(int)row
{
    FYYCategory * cat =  [FYYMetaUtil categories][row];
    return cat.subcategories;
}

- (NSInteger)numberOfRowsInMainTable:(FYYHomeDropDown *)dropDown {
    return [FYYMetaUtil categories].count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 代理方法  监听菜单的点击！
- (void)homeDropdown:(FYYHomeDropDown *)homeDropdown didSelectRowInMainTable:(int)row
{
    FYYCategory * cat =  [FYYMetaUtil categories][row];
    if (cat.subcategories.count == 0) {
        //发出通知
        [FYYNotificationCenter postNotificationName:FYYCategoryDidChageNotification object:nil userInfo:@{FYYSelectCategory : cat}];
    }
}

- (void)homeDropdown:(FYYHomeDropDown *)homeDropdown didSelectRowInSubTable:(int)subRow selectedRowInMainTable:(int)row
{
    FYYCategory * cat =  [FYYMetaUtil categories][row];
    //发出通知
    [FYYNotificationCenter postNotificationName:FYYCategoryDidChageNotification object:nil userInfo:@{FYYSelectCategory : cat, FYYSelectSubCategory: cat.subcategories[subRow]}];
}



@end
