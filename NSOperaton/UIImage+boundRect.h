//
//  UIImage+boundRect.h
//  NSOperaton
//
//  Created by Yang Mr on 2018/1/2.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (boundRect)
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
+ (UIImage *)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
@end
