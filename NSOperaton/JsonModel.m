//
//  JsonModel.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/27.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "JsonModel.h"

@interface JsonModel()
@property (nonatomic, copy, readwrite) NSString * cashAllMoneyShow;
@end

@implementation JsonModel

MJExtensionCodingImplementation

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"latestDrawHistoryModels":@"JsonSubModel"};
}
- (void)setCashAllMoney:(NSString *)cashAllMoney{
    _cashAllMoney = cashAllMoney;
    self.cashAllMoneyShow = cashAllMoney;
}

+ (instancetype)parseData{
    
    NSArray *arr = nil;
    id obj = [arr lastObject];
    DLog(@"%@==%@",obj,obj[2]);
    
#warning TODO - 解析如下类型数据结构？？？
//    "all_city": {
//    -"A": {
//        "106": "阿拉善盟",
//        "109": "鞍山市",
//        "193": "安庆市",
//        "244": "安阳市",
//        "403": "阿坝藏族羌族自治州",
//        "409": "安顺市",
//        "436": "阿里地区",
//        "446": "安康市",
//        "482": "阿克苏地区",
//        "488": "阿勒泰地区"
//    },
//    -"B": {
//        "1": "北京市",
//        "78": "保定市",
//        "96": "包头市",
//        "102": "巴彦淖尔市",
//        "111": "本溪市",
//        "126": "白山市",
//        "128": "白城市",
//        "188": "蚌埠市",
//        "200": "亳州市",
//        "238": "滨州市",
//        "314": "北海市",
//        "319": "百色市",
//        "401": "巴中市",
//        "412": "毕节市",
//        "418": "保山市",
//        "440": "宝鸡市",
//        "451": "白银市",
//        "480": "博尔塔拉蒙古自治州",
//        "481": "巴音郭楞蒙古自治州"
//    }；
    
    if (arc4random() % 2 == 0) {
        NSDictionary *dicNew = @{@"data":@{
                                         @"wi":@"1q2w3e",
                                         @"mc":@"345345",
                                         @"ti":@"1501733470",
                                         @"ms":@[@{@"no":@"1212",
                                                   @"id":@"1",
                                                   @"name":@"卡1",
                                                   @"bank":@"建行"
                                                   },
                                                 @{@"no":@"4545",
                                                   @"id":@"2",
                                                   @"name":@"卡2",
                                                   @"bank":@"弄行"
                                                   }],
                                         @"strings":@[@{@"prompt":@"123"},
                                                      @{@"prompt":@"abc"},
                                                      @{@"prompt":@"@#$"},
                                                      @{@"prompt":@"_+="}]
                                         }};
        
        [JsonSubModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"cardNum":@"no",
                     @"hisID":@"id",
                     @"name":@"name",
                     @"orderNum":@"bank"};
        }];
        
        [JsonModel mj_setupNewValueFromOldValue:^id(id object, id oldValue, MJProperty *property) {
            
            if ([property.name isEqualToString:@"dayLimitDrawCount"]) {
                NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                fmt.dateFormat = @"yyyy-MM-dd hh:mm:ss";
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:[(NSString *)oldValue longLongValue]];
                return [fmt stringFromDate:date];
            }
            
            return oldValue;
        }];
        
        
        [JsonModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"cashAllMoney":@"data.wi",
                     @"monthAllCanDrawMoney":@"data.mc",
                     @"latestDrawHistoryModels":@"data.ms",
                     @"dayLimitDrawCount":@"data.ti",
                     @"promptMessage":@"data.strings[5].prompt"};
        }];
        
        JsonModel *dicNewModel = [JsonModel mj_objectWithKeyValues:dicNew];
        NSError *error = [JsonModel mj_error];
        NSError *adErr;
        [JsonModel testError:error customError:&adErr];
        DLog(@"JsonModel Parse Error:%@==%@",error.domain,adErr.userInfo)
        if (error) {
            
        }else{
            NSDictionary *dicVa = dicNewModel.mj_keyValues;
            DLog(@"%@",[NSString stringWithFormat:@"%@",dicVa]);
        }
        NSString *file = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/bag.txt"];
        // Encoding
        [NSKeyedArchiver archiveRootObject:dicNewModel toFile:file];
        
        // Decoding
        JsonModel *decodedModel = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
        
        return decodedModel;
    }
    
    
    
    [JsonModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"cashAllMoney":@"data.withdraw.withdrawamount",
                 @"monthAllCanDrawMoney":@"data.withdraw.monthratio",
                 
                 @"latestDrawHistoryModels":@"data.cards",
                 @"dayLimitDrawCount":@"data.withdraw.canwithdraw",
                 @"promptMessage":@"data.strings[1].prompt"};
    }];
    
    [JsonSubModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"cardNum":@"cardno",
                 @"hisID":@"debitcardid",
                 @"name":@"idname",
                 @"orderNum":@"bank"};
    }];
    
    id data = [JsonModel jsonDic];
    JsonModel *model = [JsonModel mj_objectWithKeyValues:data];
    DLog(@"%@==%@==%@==%@",model.cashAllMoney,model.monthAllCanDrawMoney,model.dayLimitDrawCount,model.latestDrawHistoryModels);
    JsonSubModel *sub = model.latestDrawHistoryModels[0];
    DLog(@"%@==%@==%@==%@",sub.cardNum,sub.hisID,sub.orderNum,sub.name)
    DLog(@"%@",model.mj_keyValues);
    return model;
}
+ (void)testError:(NSError *)error customError:(NSError **)cusError{
//    NSAssert(!error, @"数据类型错误");
    
    //异常的名称
    NSString *exceptionName = @"自定义异常原因";
    //异常的原因
    NSString *exceptionReason = error.domain;
    //异常的信息
    NSDictionary *exceptionUserInfo = nil;
    
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionUserInfo];
    
    if (error) {
        //抛异常
//        DLog(@"%@=%@",exception.name,exception.reason)
        @throw exception;
    }else{
        NSDictionary *userInfo = @{@"msg":@"这个是自定义get adddress error"};
        NSErrorDomain domain = @"自定义error";
        NSInteger code = 10086;
        NSError *err = [[NSError alloc] initWithDomain:domain code:code userInfo:userInfo];
        *cusError = err;
    }
}
+ (id)jsonDic{
    return [JsonModel serializtionObjectWithJsonString:[JsonModel jsonString]];
}
//JSON字符串转化为对象(数组，字典)
+ (id )serializtionObjectWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil || ![jsonString isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
    if(err)
    {
        DLog(@"JSON字符串转化为对象(数组，字典)失败：%@",err);
        return nil;
    }
    return jsonObj;
}
+ (NSString *)jsonString{
    NSString *jsonStr = @"\
    {\
        \"code\": 0,\
        \"data\": {\
            \"cards\": [\
                       {\
                           \"debitcardid\": 4,\
                           \"bank\": \"\",\
                           \"idname\": \"xxx\",\
                           \"cardno\": \"**** **** **** 1234\"\
                       }\
                       ],\
    \"strings\":[\
                {\
                },\
                {\
                    \"prompt\":\"传递消息\",\
                },\
                ],\
            \"withdraw\": {\
                \"withdrawamount\": \"1344q\",\
                \"monthwithdrawed\": 0,\
                \"daywithdrawed\": 0,\
                \"oneratio\": \"1000000\",\
                \"monthratio\": 3000000,\
                \"minmoney\": \"100\",\
                \"canwithdraw\": 1,\
                \"hints\": [\
                           \"*余额<大于等于1元>可提现\",\
                           \"*每日最多申请提现 <10次>，单笔不得超过 <10,000元>\",\
                           \"*每月最多可申请提现 <30,000元>\"\
                           ],\
                \"ruleurl\": \"http://www.youhaodongxi.com\",\
                \"saurl\": \"\",\
                \"latestwithdarw\": 0\
            }\
        },\
        \"msg\": \"\"\
    }";
    return jsonStr;
}
@end
