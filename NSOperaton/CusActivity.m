//
//  CusActivity.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/8/18.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "CusActivity.h"

//NSString *const UIActivityTypeZSCustomMine = @"ZSCustomActivityMine";
//
//
//@implementation CusActivity
//- (UIActivityType)activityType{
//    return UIActivityTypeZSCustomMine;
//}
//- (NSString *)activityTitle{
//    return @"自定义";
//}
//- (UIImage *)activityImage{
//    return [UIImage imageNamed:@"2.png"];
//}
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

@interface CusActivity()

@end

@implementation CusActivity

- (instancetype)initWithTitle:(NSString *)title type:(NSString *)type{
    if (self = [super init]) {
        self.title = title;
        self.typeString = type;
    }
    return self;
}
- (NSString *)activityTitle{
    return self.title;
}
- (NSString *)activityType{
    return self.typeString;
}
+ (UIActivityCategory)activityCategory{
    return UIActivityCategoryShare;
}
- (UIImage *)activityImage{
//    NSString *weixinImageString = @"ic_share_wechat";
//    NSString *friendsImageString = @"ic_share_circle";
//    NSString *imageName = [self.type isEqualToString:ActivityServiceWeixin] ?      weixinImageString: friendsImageString;
////    NSData *imageData = [NSData dataWithBase64EncodedString:imageName];
////    return [UIImage imageWithData:imageData scale:2.0];
//    return [UIImage imageNamed:imageName];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
    
    return [UIImage imageNamed:@"cash_ic_reason"];
}
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    return YES;
}
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
}
//- (UIViewController *)activityViewController{
//    return nil;
//}
- (void)performActivity{
    if ([self.typeString isEqualToString:ActivityCusServiceWeixin]) {
        NSLog(@"在这里可以实现微信分享代码");
    }else if([self.typeString isEqualToString:ActivityCusServiceWeixinFriends]){
        NSLog(@"在这里可以实现朋友圈分享代码");
    }else{
        NSLog(@"unknown");
    }
}



//链接：http://www.jianshu.com/p/d500fb72a079
@end
