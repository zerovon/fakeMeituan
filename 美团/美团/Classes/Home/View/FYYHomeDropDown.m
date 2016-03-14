//
//  FYYHomeDropDown.m
//  美团
//
//  Created by 冯钰洋 on 16/3/8.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYHomeDropDown.h"
#import "FYYCategory.h"
#import "FYYHomeDropDownMainCell.h"
#import "FYYHomeDropDownSubCell.h"
#import  "FYYRegion.h"

@interface FYYHomeDropDown() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;
@property(nonatomic, assign) NSInteger selectedMainRow;

@end

@implementation FYYHomeDropDown

+ (instancetype)dropDown{
    return [[[NSBundle mainBundle] loadNibNamed:@"FYYHomeDropDown" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib{
    
        //FYYCategoryViewController的view因为popover缩小很多，autoresizingMask保证categoryDown不跟随控件的尺寸而伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return [self.dataSource numberOfRowsInMainTable:self];
    } else {
        return [self.dataSource homeDropdown:self subDataForRowInMainTable:self.selectedMainRow].count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) { //主表显示内容
        cell = [FYYHomeDropDownMainCell cellWithTableView:tableView];
        
        //显示文字

        cell.textLabel.text = [self.dataSource homeDropdown:self titleForRowInMainTable:indexPath.row];
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:iconForRowInMainTable:)]) {
            cell.imageView.image = [UIImage imageNamed:[self.dataSource homeDropdown:self iconForRowInMainTable:indexPath.row]];
        }
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:highIconForRowInMainTable:)]) {
            cell.imageView.highlightedImage = [UIImage imageNamed:[self.dataSource homeDropdown:self highIconForRowInMainTable:indexPath.row]];
        }
//        cell.imageView.image = [UIImage imageNamed:category.small_icon];
        if ([self.dataSource homeDropdown:self subDataForRowInMainTable:indexPath.row].count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {//从表显示内容
        cell = [FYYHomeDropDownSubCell cellWithTableView:tableView];
        cell.textLabel.text = [self.dataSource homeDropdown:self subDataForRowInMainTable:self.selectedMainRow][indexPath.row];
    }
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        self.selectedMainRow = indexPath.row;
            //刷新右边的数据
            [self.subTableView reloadData];
        //通知代理
        if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectRowInMainTable:)]) {
            [self.delegate homeDropdown:self didSelectRowInMainTable:indexPath.row];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectRowInSubTable:selectedRowInMainTable:)]) {
            [self.delegate homeDropdown:self didSelectRowInSubTable:indexPath.row selectedRowInMainTable:self.selectedMainRow];
        }
    }
}

@end
