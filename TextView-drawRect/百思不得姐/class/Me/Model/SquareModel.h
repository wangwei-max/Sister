//
//  SquareModel.h
//  百思不得姐
//
//  Created by MAX on 16/6/22.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SquareModel : NSObject
/** 图片 */
@property (nonatomic,copy) NSString *icon;

/** 标题文字*/
@property (nonatomic,copy) NSString *name;

/** 链接*/
@property (nonatomic,copy) NSString *url;
@end
