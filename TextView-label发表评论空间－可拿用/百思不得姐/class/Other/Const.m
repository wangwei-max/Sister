

#import <UIKit/UIKit.h>
//精华－所有标题的高度和Y
CGFloat const TitlesViewH = 35;
CGFloat const TitlesViewY = 64;

//精华－cell－间距
CGFloat const TopicCellMargin = 10;
//精华－cell－底部工具条高度
CGFloat const TopicCellBottomBarH = 44;
//精华－cell－文字的 Y
CGFloat const TopicCellTextY = 55;

//精华－图片最大高度
CGFloat const TopicCellPcitureMaxH = 1500;
//精华－图片超出后的高度
CGFloat const TopicCellPcitureBreakH = 250;

/**User模型－性别属性值*/
NSString *const UserSexMale = @"m";
NSString *const UserSexFemale = @"f";


/** 精华－cell－最热评论文字*/
CGFloat const TopicCellTopCmtTitle = 20;

/**tabbar被点击的通知名字*/
NSString *const TabBarDidSelectNotification = @"TabBarDidSelectNotification";
/**tabbar被点击的通知 - 被点击的控制器的index key*/
NSString *const SelectControlllerIndexKey = @"SelectControlllerIndexKey";
/**tabbar被点击的通知 - 被点击的控制器的key*/
NSString *const SelectControlllerKey = @"SelectControlllerKey";