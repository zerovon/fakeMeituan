//
//  FYYHomeDropDown.h
//  美团
//
//  Created by 冯钰洋 on 16/3/8.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FYYHomeDropDown;

//@protocol FYYHomeDropDownData <NSObject>
//- (NSString *)title;
//- (NSString *)icon;
//- (NSArray *)subdata;
//- (NSString *)selectedIcon;
//
//@end

@protocol FYYHomeDropDownDataSource <NSObject>
/**
 *  左边的表格一共有多少行
 *
 *  @param dropDown 下拉view
 *
 */
- (NSInteger)numberOfRowsInMainTable:(FYYHomeDropDown *)dropDown;
/**
 *  返回左边表格每一行的名字
 *
 *  @param dropDown 下拉菜单view
 *  @param row      第几行
 *
 *  @return <#return value description#>
 */
- (NSString *)homeDropdown:(FYYHomeDropDown *)dropDown titleForRowInMainTable:(int)row;
/**
 *  左边表格每一行的子数据
 *
 *  @param dropDown <#dropDown description#>
 *  @param row      <#row description#>
 *
 *  @return <#return value description#>
 */
- (NSArray *)homeDropdown:(FYYHomeDropDown *)dropDown subDataForRowInMainTable:(int)row;
@optional
- (NSString  *)homeDropdown:(FYYHomeDropDown *)dropDown iconForRowInMainTable:(int)row;
- (NSString *)homeDropdown:(FYYHomeDropDown *)dropDown highIconForRowInMainTable:(int)row;


@end

@protocol FYYHomeDropDownDelegate <NSObject>

@optional

- (void)homeDropdown:(FYYHomeDropDown *)homeDropdown didSelectRowInMainTable:(int)row;
- (void)homeDropdown:(FYYHomeDropDown *)homeDropdown didSelectRowInSubTable:(int)subRow selectedRowInMainTable: (int)row;

@end

@interface FYYHomeDropDown : UIView

+ (instancetype)dropDown;

@property (nonatomic, weak) id<FYYHomeDropDownDataSource> dataSource;
@property (nonatomic, weak) id<FYYHomeDropDownDelegate> delegate;

//@property (nonatomic, strong) NSArray *regions;

@end
