//
//  UIBarButtonItem+WW.h
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WW)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage action:(SEL)action target:(id)target;
@end
