//
//  whiteplaceholderTF.m
//  百思不得姐
//
//  Created by MAX on 16/5/24.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "whiteplaceholderTF.h"
#import <objc/runtime.h>

@implementation whiteplaceholderTF

//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 10, 100, 100) withAttributes:@{
//                                                       NSForegroundColorAttributeName : [UIColor grayColor],
//                                                       NSFontAttributeName : self.font
//                                                       }];
//}

//-(void)awakeFromNib
//{
//    unsigned int count = 0 ;
//    
//    //拷贝出所有的变量列表
//    Ivar *ivars  =  class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i<count; i++) {
//        //取出成员变量
//        Ivar ivar =  *(ivars+i);
//        
//        //打印成员变量名字
//        WWLog(@"%s",ivar_getName(ivar));
//    }
//    free(ivars);
//}

-(BOOL)becomeFirstResponder
{
    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
    placeholderLabel.textColor = [UIColor whiteColor];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder
{
    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
    placeholderLabel.textColor = [UIColor grayColor];
    return [super resignFirstResponder];
}
-(void)awakeFromNib
{
    [self resignFirstResponder];
    
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    [self setValue:placeholderColor forKey:@"_placeholderLabel"];
}

@end
