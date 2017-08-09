//
//  NSObject+url.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/6/28.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (url)
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL;
/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageNewSizeWithURL:(id)URL;
@end
