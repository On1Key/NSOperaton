//
//  AnalysisManager.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/24.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "AnalysisManager.h"

@implementation AnalysisManager
+ (void)createAllHooks
{
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){
                                   //用户统计代码写在此处
                                   NSLog(@"*******************==%@==%@==%@",info.originalInvocation,info.arguments,@"viewWillAppear:");
                               }
                                    error:NULL];
    [UIViewController aspect_hookSelector:@selector(viewDidDisappear:)
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> info){
                                   //用户统计代码写在此处
                                   NSLog(@"*******************==%@==%@==%@",info.originalInvocation,info.arguments,@"viewDidDisappear:");
                               }
                                    error:NULL];
    
    [UIControl aspect_hookSelector:@selector(sendAction:to:forEvent:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        NSLog(@"*******************==%@==%@==%@",info.originalInvocation,info.arguments,@"sendAction:to:forEvent:");
    } error:NULL];
    
    
    
//    [UIGestureRecognizer aspect_hookSelector:@selector(<#selector#>) withOptions:<#(AspectOptions)#> usingBlock:<#(id)#> error:<#(NSError *__autoreleasing *)#>]
}
@end
