//
//  CollectionViewCell.m
//  NSOperaton
//
//  Created by Yang Mr on 2018/3/8.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()
/**<#statements#>*/
@property (nonatomic, strong) UIImageView * imageview;
@end

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:imageView];
        _imageview = imageView;
        imageView.image = [UIImage imageWithColor:COLOR_RANDOM];
    }
    return self;
}

@end

@implementation UIImage(color)
+ (UIImage *)imageWithColor:(UIColor *)color

{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}
@end
