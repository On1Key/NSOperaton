//
//  TableViewCell.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/6/29.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSObject+url.h"
#import <AVFoundation/AVFoundation.h>

@interface TableViewCell()
/**<#statements#>*/
@property (nonatomic, strong) NSMutableArray * allConstraints;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.allConstraints = [NSMutableArray array];
        
        NSLayoutConstraint *iocnTop = [NSLayoutConstraint constraintWithItem:self.iocnIV attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
        NSLayoutConstraint *iocnLeft = [NSLayoutConstraint constraintWithItem:self.iocnIV attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
        NSLayoutConstraint *iconW = [NSLayoutConstraint constraintWithItem:self.iocnIV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
        NSLayoutConstraint *iconH = [NSLayoutConstraint constraintWithItem:self.iocnIV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
        
        NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
        NSLayoutConstraint *labelBot = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
        NSLayoutConstraint *labelleft = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iocnIV attribute:NSLayoutAttributeRight multiplier:0 constant:20];
        NSLayoutConstraint *labelRight = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:10];
        
        [self.allConstraints addObject:iocnTop];
        [self.allConstraints addObject:iocnLeft];
        [self.allConstraints addObject:iconW];
        [self.allConstraints addObject:iconH];
        
        [self.allConstraints addObject:labelleft];
        [self.allConstraints addObject:labelTop];
        [self.allConstraints addObject:labelBot];
        [self.allConstraints addObject:labelRight];
        
        [self addConstraints:self.allConstraints];
        
    }
    return self;
}
- (void)setCellModel:(CellModel *)cellModel{
    _cellModel = cellModel;
    
    
    if (![cellModel isKindOfClass:[CellModel class]]) {
        return;
    }
    
    self.nameLabel.attributedText = [cellModel.str replaceOriginalContainNumStringFromAttribute:@{} toAttribute:@{NSForegroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    //1、首先对image付值
    //    cell.imageView.image=[UIImage imageNamed:_arr[arc4random()%5]];
    //    //2、调整大小
    //    CGSize itemSize = CGSizeMake(40, 40);
    //    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    //    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    //    [cell.imageView.image drawInRect:imageRect];
    //    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    
    NSString *url = cellModel.url;
    
//    UIImageView显示视频流
//    http://www.jianshu.com/p/7b5a584a4371
    [self.iocnIV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"%ld==%@===%@",indexPath.row,error,image);
    }];
    
    
//    NSLayoutConstraint *iconW = [NSLayoutConstraint constraintWithItem:self.iocnIV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:lastSize.width];
//    NSLayoutConstraint *iconH = [NSLayoutConstraint constraintWithItem:self.iocnIV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:lastSize.height];
//    
//    [self.allConstraints removeObjectAtIndex:2];
//    [self.allConstraints removeObjectAtIndex:2];
//    
//    [self.allConstraints addObject:iconW];
//    [self.allConstraints addObject:iconH];
//    
//    [self removeConstraints:self.allConstraints];
//    [self addConstraints:self.allConstraints];

}
- (void)layoutSubviews{
    [super layoutSubviews];
//    self.iocnIV.frame = CGRectMake(10, 10, _cellModel.imageSize.width, _cellModel.imageSize.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
