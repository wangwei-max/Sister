//
//  RecommendCell.h
//  百思不得姐
//
//  Created by MAX on 16/5/17.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recommendCategory.h"
@interface RecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *leftview;
@property (nonatomic,strong) recommendCategory *category;
@end
