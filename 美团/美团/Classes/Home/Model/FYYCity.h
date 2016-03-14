//
//  FYYCity.h
//  美团
//
//  Created by 冯钰洋 on 16/3/10.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FYYCity : NSObject
//城市名称
@property (nonatomic, copy) NSString *name;

//城市拼音
@property (nonatomic, copy) NSString *pinYin;

//城市拼音缩写
@property (nonatomic, copy) NSString *pinYinHead;

//城市地区
@property (nonatomic, strong) NSArray *regions;

@end
