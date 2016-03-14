//
//  FYYCity.m
//  美团
//
//  Created by 冯钰洋 on 16/3/10.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYCity.h"
#import "MJExtension.h"
#import "FYYRegion.h"

@implementation FYYCity

- (NSDictionary *) objectClassInArray{
    return @{@"regions" : [FYYRegion class]};
}

@end
