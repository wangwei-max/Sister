//
//  PlaceHolderTextView.h
//  百思不得姐
//
//  Created by MAX on 16/6/27.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderTextView : UITextView
/** 占位文字*/
@property (nonatomic,copy) NSString *placeholder;

/** 占位文字颜色*/
@property (nonatomic,strong) UIColor *placeholderColor;

@end
