//
//  WebController.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/12.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebController : UIViewController
/**<#statements#>*/
@property (nonatomic, strong) NSURL * url;
/**本地html数据*/
@property (nonatomic, strong) NSString * localHtmlData;
/**是否是本地数据*/
//@property (nonatomic) BOOL isLocalData;
@end
