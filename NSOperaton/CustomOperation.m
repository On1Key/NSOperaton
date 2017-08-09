//
//  CustomOperation.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/4/20.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "CustomOperation.h"

@interface CustomOperation () {
    BOOL        executing;  // 执行中
    BOOL        finished;   // 已完成
}
@end
@implementation CustomOperation
- (id)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

- (void)start {
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    NSLog(@"main begin");
    @try {
        // 必须为自定义的 operation 提供 autorelease pool，因为 operation 完成后需要销毁。
        @autoreleasepool {
            // 提供一个变量标识，来表示需要执行的操作是否完成了，当然，没开始执行之前，为NO
            BOOL taskIsFinished = NO;
            // while 保证：只有当没有执行完成和没有被取消，才执行自定义的相应操作
            while (taskIsFinished == NO && [self isCancelled] == NO){
                // 自定义的操作
                //sleep(10);  // 睡眠模拟耗时操作
                NSLog(@"currentThread = %@", [NSThread currentThread]);
                NSLog(@"mainThread    = %@", [NSThread mainThread]);
                
                // 这里相应的操作都已经完成，后面就是要通知KVO我们的操作完成了。
                taskIsFinished = YES;
            }
            [self completeOperation];
            
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception %@", e);
    }
    NSLog(@"main end");
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

// 已经弃用，使用 isAsynchronous 代替
//- (BOOL)isConcurrent {
//    return NO;
//}

- (BOOL)isAsynchronous {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

// 执行操作
- (BOOL)performOperation:(NSOperation*)anOp
{
    BOOL        ranIt = NO;
    
    if ([anOp isReady] && ![anOp isCancelled])
    {
        if (![anOp isAsynchronous]) {
            [anOp start];
        }
        else {
            [NSThread detachNewThreadSelector:@selector(start)
                                     toTarget:anOp withObject:nil];
        }
        ranIt = YES;
    }
    else if ([anOp isCancelled])
    {
        // If it was canceled before it was started,
        //  move the operation to the finished state.
        [self willChangeValueForKey:@"isFinished"];
        [self willChangeValueForKey:@"isExecuting"];
        executing = NO;
        finished = YES;
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
        
        // Set ranIt to YES to prevent the operation from
        // being passed to this method again in the future.
        ranIt = YES;
    }
    return ranIt;
}

@end
