//
//  UserModel.h
//  百思不得姐
//
//  Created by MAX on 16/6/16.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserM : NSObject
/** 用户 */
@property (nonatomic ,copy)NSString *username;
/** 性别 */
@property (nonatomic ,copy)NSString *sex;
/** 头像 */
@property (nonatomic ,copy)NSString *profile_image;
@end
