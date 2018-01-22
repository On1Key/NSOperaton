//
//  YYTextField.m
//  ss
//
//  Created by Yang Mr on 2017/12/20.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "YYTextField.h"

@implementation YYTextField
/**初始化一个搜索类型输入框*/
- (instancetype)initSearchTypeWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor greenColor];
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor brownColor].CGColor;
        self.layer.borderWidth = 0.5;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        CGFloat textfieldWH = frame.size.height;
        CGFloat searchIvMargin = 10;
        CGFloat searchIvWH = textfieldWH - searchIvMargin * 2;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textfieldWH, textfieldWH)];
        UIImageView *searchIV = [[UIImageView alloc] initWithFrame:CGRectMake(searchIvMargin, searchIvMargin, searchIvWH, searchIvWH)];
        searchIV.contentMode = UIViewContentModeScaleAspectFit;
        searchIV.image = [UIImage imageNamed:@"nav_ic_search"];
        [leftView addSubview:searchIV];
        self.leftView = leftView;
    }
    return self;
}

@end
