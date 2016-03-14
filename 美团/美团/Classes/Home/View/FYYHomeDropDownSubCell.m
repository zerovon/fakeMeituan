//
//  FYYHomeDropDownSubCell.m
//  美团
//
//  Created by 冯钰洋 on 16/3/10.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYHomeDropDownSubCell.h"

@implementation FYYHomeDropDownSubCell

+ (instancetype) cellWithTableView:(UITableView *)tableView
{
    static NSString *mainID = @"sub";
    FYYHomeDropDownSubCell * cell = [tableView dequeueReusableCellWithIdentifier:mainID];
    if (!cell) {
        cell = [[FYYHomeDropDownSubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mainID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        self.backgroundView = bgView;
        
        UIImageView *seletedBgView = [[UIImageView alloc] init];
        seletedBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
        self.selectedBackgroundView = seletedBgView;
    }
    return self;
}

@end
