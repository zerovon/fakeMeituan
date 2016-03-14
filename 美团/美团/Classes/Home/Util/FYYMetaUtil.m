//
//  FYYMetaUtil.m
//  美团
//
//  Created by 冯钰洋 on 16/3/13.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYMetaUtil.h"
#import "FYYCity.h"
#import "MJExtension.h"
#import "FYYCategory.h"
#import "FYYSort.h"

@implementation FYYMetaUtil

static NSArray *_cities;

static NSArray *_categories;

static NSArray *_sorts;

+ (NSArray *)cities {
    if (_cities == nil) {
        _cities = [FYYCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

+ (NSArray *)categories {
    if (_categories == nil) {
        _categories = [FYYCategory objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

+(NSArray *)sorts {
    if (_sorts == nil) {
        _sorts = [FYYSort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}

@end
