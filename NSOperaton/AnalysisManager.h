//
//  AnalysisManager.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/24.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalysisManager : NSObject
+ (void)createAllHooks;
+ (NSArray *)runningProcesses;
@end
