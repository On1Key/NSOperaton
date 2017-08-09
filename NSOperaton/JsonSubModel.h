//
//  JsonSubModel.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/27.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonSubModel : NSObject
/**id*/
@property (nonatomic, copy) NSString * hisID;
/**name*/
@property (nonatomic, copy) NSString * name;
/**卡号*/
@property (nonatomic, copy) NSString * cardNum;
/**申请单号*/
@property (nonatomic, copy) NSString * orderNum;
/**申请时间*/
@property (nonatomic, copy) NSString * reqTime;
/**提现金额*/
@property (nonatomic, copy) NSString * drawMoney;
/**提现状态id*/
@property (nonatomic, copy) NSString * cashDrawStateID;
@end
