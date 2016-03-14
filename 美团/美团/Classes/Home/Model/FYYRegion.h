//
//  FYYRegion.h
//  美团
//
//  Created by 冯钰洋 on 16/3/10.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYYRegion : NSObject
//区域名字
@property (nonatomic, copy) NSString *name;
//子区域
@property (nonatomic, strong) NSArray *subregions;

@end
