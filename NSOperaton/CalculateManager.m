//
//  CalculateManager.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/21.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "CalculateManager.h"

@interface CalculateManager()
@end

@implementation CalculateManager
- (CalculateManager *(^)(int))add{
    return ^CalculateManager * (int value){
        _result += value;
        return self;
    };
}
- (long (^)(int, int)) sumBlock {
    int base = 100;
    return [ ^ long (int a, int b) {
        return base + a + b;
    } copy];
}
@end
