

#import <UIKit/UIKit.h>

typedef enum {
    TypeAll = 1,
    TypePicture = 10,
    TypeWord = 29,
    TypeVoice = 31,
    TypeVideo= 41,
}TopicType;

UIKIT_EXTERN CGFloat const TitlesViewH ;
UIKIT_EXTERN CGFloat const TitlesViewY ;
//精华－cell－间距
UIKIT_EXTERN CGFloat const TopicCellMargin;
//精华－cell－底部工具条高度
UIKIT_EXTERN CGFloat const TopicCellBottomBarH;
//精华－cell－文字的 Y
UIKIT_EXTERN CGFloat const TopicCellTextY;

////精华－cell－图片最大高度
UIKIT_EXTERN CGFloat const TopicCellPcitureMaxH;
/** 精华－cell－图片帖子一旦超过最大高度就用Break*/
UIKIT_EXTERN CGFloat const TopicCellPcitureBreakH;

/**User模型－性别属性值*/
UIKIT_EXTERN NSString *const UserSexMale;
UIKIT_EXTERN NSString *const UserSexFemale;

/** 精华－cell－最热评论文字*/
UIKIT_EXTERN CGFloat const TopicCellTopCmtTitle;

/**tabbar被点击的通知名字*/
UIKIT_EXTERN NSString *const TabBarDidSelectNotification;
/**tabbar被点击的通知 - 被点击的控制器的index key*/
UIKIT_EXTERN NSString *const SelectControlllerIndexKey;
/**tabbar被点击的通知 - 被点击的控制器的key*/
UIKIT_EXTERN NSString *const SelectControlllerKey;