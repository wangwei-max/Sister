//
//  RecommendTagsModel.h
//  百思不得姐
//
//  Created by MAX on 16/5/23.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendTagsModel : NSObject
/**
 image_list : ,
theme_id : 9826,
theme_name : 召集动漫迷,
is_sub : 0,
is_default : 0,
sub_number : 18397
 */
@property (nonatomic,copy) NSString *image_list;
@property (nonatomic,copy) NSString *theme_name;
@property (nonatomic,assign) NSInteger sub_number;
@end
