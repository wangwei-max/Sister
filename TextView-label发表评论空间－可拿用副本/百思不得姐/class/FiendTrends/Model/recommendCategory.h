//
//  recommendCategory.h
//  百思不得姐
//
//  Created by MAX on 16/5/17.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "recommendCategory.h"
@interface recommendCategory : NSObject
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger total;

//当前页码
@property (nonatomic,assign) NSInteger currentPage;


//类对应的数据
@property (nonatomic,strong) NSMutableArray *user;

@end
