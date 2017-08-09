//
//  JsonModel.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/27.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonSubModel.h"

@interface JsonModel : NSObject

/**<#statements#>*/
@property (nonatomic) NSInteger no;
/**<#statements#>*/
@property (nonatomic) BOOL ok;

/**提现总金额*/
@property (nonatomic, copy) NSString * cashAllMoney;
/**提现总金额千分位显示*/
@property (nonatomic, copy, readonly) NSString * cashAllMoneyShow;
/**本月已提现*/
@property (nonatomic, copy) NSString * monthDrawedMoney;
/**本月已提现千分位显示*/
@property (nonatomic, copy, readonly) NSString * monthDrawedMoneyShow;
/**本月提现额度*/
@property (nonatomic, copy) NSString * monthAllCanDrawMoney;
/**本月可提现，自动计算*/
@property (nonatomic, copy, readonly) NSString * monthCanDrawMoney;
/**本月可提现，自动计算千分位显示*/
@property (nonatomic, copy, readonly) NSString * monthCanDrawMoneyShow;
/**今日已提现*/
@property (nonatomic, copy) NSString * dayDrawedMoney;
/**今日已提现*/
@property (nonatomic, copy, readonly) NSString * dayDrawedMoneyShow;
/**单次最高提现额度*/
@property (nonatomic, copy) NSString * maxOnceDrawMoney;
/**单次最小提现额度*/
@property (nonatomic, copy) NSString * minOnceDrawMoney;
/**单日提现次数限制*/
@property (nonatomic, copy) NSString * dayLimitDrawCount;
/**提现规则*/
@property (nonatomic, copy) NSString * ruleUrl;
/**绑卡服务协议*/
@property (nonatomic, copy) NSString * cardBindServiceUrl;
/**最近一笔提现记录信息*/
@property (nonatomic, strong) NSArray< JsonSubModel *> * latestDrawHistoryModels;

/**提现提示信息*/
@property (nonatomic, copy) NSString * promptMessage;
/**提现提示信息富文本*/
@property (nonatomic, copy, readonly) NSAttributedString * promptMessageAttStr;

/**银行卡*/
//@property (nonatomic, strong) BankCardModel * cardModel;

/**提现提示信息*/
//@property (nonatomic, strong) NSArray * cashInfos;

/**用户要提现的金额*/
@property (nonatomic, copy) NSString * withDrawMoney;

/**历史使用*/
@property (nonatomic) NSInteger page;

+ (instancetype)parseData;
+ (NSString *)jsonString;
+ (id)jsonDic;
@end
