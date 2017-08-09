//
//  CalculateManager.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/21.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateManager : NSObject
/**<#statements#>*/
@property (nonatomic) NSInteger result;
- (CalculateManager *(^)(int))add;
- (long (^)(int, int)) sumBlock;
@end
