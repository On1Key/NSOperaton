//
//  CusActivity.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/8/18.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString * const ActivityCusServiceWeixin = @"weixin";
static NSString * const ActivityCusServiceWeixinFriends = @"weixin_friends";

@interface CusActivity : UIActivity

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *typeString;
@property (nonatomic) NSString *urlString;
@property (nonatomic) NSString *shareDescription;
@property (nonatomic) NSString *shareTitle;
@property (nonatomic) UIImage *image;
- (instancetype)initWithTitle:(NSString *)title type:(NSString *)type;

@end
