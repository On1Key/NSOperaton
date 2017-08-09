//
//  CustomOperation.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/4/20.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomOperation : NSOperation
- (BOOL)performOperation:(NSOperation*)anOp;    // 执行操作调用这个方法
@end
