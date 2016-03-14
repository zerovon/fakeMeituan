//
//  FYYCityGroup.h
//  美团
//
//  Created by 冯钰洋 on 16/3/10.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYYCityGroup : NSObject

//组别标题
@property (nonatomic, copy) NSString *title;

//组下面的所有城市
@property (nonatomic, strong) NSArray *cities;

@end
