//
//  NSDate+WWExtension.h
//  百思不得姐
//
//  Created by MAX on 16/5/31.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WWExtension)
-(NSDateComponents *)deltaFrom:(NSDate *)from;

//是否是今年
-(BOOL)isThisYear;

//是否是当天
-(BOOL)isThisDay;

//是否是昨天
-(BOOL)isYesterday;
@end
