//
//  FYYDistrictViewController.m
//  美团
//
//  Created by 冯钰洋 on 16/3/10.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYDistrictViewController.h"
#import "FYYHomeDropDown.h"
#import "UIView+Extension.h"
#import "FYYCityViewController.h"
#import "FYYNavigationController.h"
#import "FYYRegion.h"
#import "FYYMetaUtil.h"
#import "FYYConst.h"

@interface FYYDistrictViewController () <FYYHomeDropDownDataSource, FYYHomeDropDownDelegate>
- (IBAction)chageCity;

@end

@implementation FYYDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *titleBar = [self.view.subviews firstObject];
    
    FYYHomeDropDown *dropDown = [FYYHomeDropDown dropDown];
    dropDown.y = titleBar.height;
    dropDown.dataSource = self;
    dropDown.delegate = self;
    [self.view addSubview:dropDown];
    
    //设置控制器在poppver中的尺寸
    self.preferredContentSize = CGSizeMake(dropDown.width, CGRectGetMaxY(dropDown.frame));
}

/**
 *  切换城市
 */
- (IBAction)chageCity {
    [self.popover dismissPopoverAnimated:YES];
    FYYCityViewController *city = [[FYYCityViewController alloc] init];
    FYYNavigationController *nav = [[FYYNavigationController alloc] initWithRootViewController:city];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

#pragma mark -下拉菜单数据源
- (NSString *)homeDropdown:(FYYHomeDropDown *)dropDown titleForRowInMainTable:(int)row
{
    FYYRegion * region =  self.regions[row];
    return  region.name;
}
- (NSString *)homeDropdown:(FYYHomeDropDown *)dropDown iconForRowInMainTable:(int)row {
    return nil;
}

- (NSString *)homeDropdown:(FYYHomeDropDown *)dropDown highIconForRowInMainTable:(int)row {
    return nil;
}


- (NSArray *)homeDropdown:(FYYHomeDropDown *)dropDown subDataForRowInMainTable:(int)row
{
    FYYRegion * region =  self.regions[row];
    return  region.subregions;
}

-(NSInteger)numberOfRowsInMainTable:(FYYHomeDropDown *)dropDown
{
    return self.regions.count;
}

#pragma mark - 下拉菜单代理方法
- (void)homeDropdown:(FYYHomeDropDown *)homeDropdown didSelectRowInMainTable:(int)row
{
    FYYRegion * region =  self.regions[row];
    if (region.subregions.count  == 0) {
                [FYYNotificationCenter postNotificationName:FYYDistrictDidChageNotification object:nil userInfo:@{FYYSelectDistrict : region}];
    }
    
}

- (void)homeDropdown:(FYYHomeDropDown *)homeDropdown didSelectRowInSubTable:(int)subRow selectedRowInMainTable:(int)row
{
    FYYRegion * region =  self.regions[row];
    [FYYNotificationCenter postNotificationName:FYYDistrictDidChageNotification object:nil userInfo:@{FYYSelectDistrict : region, FYYSelectSubDistrict:region.subregions[subRow]}];
}


@end
