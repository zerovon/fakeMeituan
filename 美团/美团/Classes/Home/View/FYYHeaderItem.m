//
//  FYYHeaderItem.m
//  美团
//
//  Created by 冯钰洋 on 16/3/8.
//  Copyright © 2016年 冯钰洋. All rights reserved.
//

#import "FYYHeaderItem.h"

@interface FYYHeaderItem()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;



@end

@implementation FYYHeaderItem

+ (instancetype)item{
    return [[[NSBundle mainBundle] loadNibNamed:@"FYYHeaderItem" owner:nil options:nil] firstObject];
}

- (void) addTarget:(id)target action:(SEL)action
{
    [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
