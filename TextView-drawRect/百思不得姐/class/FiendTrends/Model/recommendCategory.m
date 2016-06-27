//
//  recommendCategory.m
//  百思不得姐
//
//  Created by MAX on 16/5/17.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "recommendCategory.h"
#import <MJExtension.h>

@implementation recommendCategory
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}


-(NSMutableArray *)user
{
    if (!_user) {
        _user = [NSMutableArray array];
    }
    return _user;
}
@end
