//
//  FYYHomeDropDown.m
//  美团
//
//  Created by 冯钰洋 on 16/3/8.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYHomeDropDown.h"

@implementation FYYHomeDropDown

+ (instancetype)dropDown{
    return [[[NSBundle mainBundle] loadNibNamed:@"FYYHomeDropDown" owner:nil options:nil] firstObject];
}


@end
