//
//  userCell.h
//  百思不得姐
//
//  Created by MAX on 16/5/19.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface userCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageV;

@property (nonatomic,strong) UserModel *usermodel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *count;
@end
