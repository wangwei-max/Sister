//
//  CommentModel.m
//  百思不得姐
//
//  Created by MAX on 16/6/16.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "CommentModel.h"
#import "MJExtension.h"
@implementation CommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}
@end
