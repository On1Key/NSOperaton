//
//  CellModel.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/6/29.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject
/**<#statements#>*/
@property (nonatomic, copy) NSString * str;
/**<#statements#>*/
@property (nonatomic, copy) NSString * url;
/**<#statements#>*/
@property (nonatomic, readonly) CGSize imageSize;
+ (NSArray *)allModels;
@end
