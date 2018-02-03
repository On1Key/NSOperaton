//
//  DBModel.h
//  NSOperaton
//
//  Created by Yang Mr on 2018/2/2.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,DBFileType){
    DBFileTypeDB = 10,//库
    DBFileTypeTable,//表
    DBFileTypeColumn,//列
    DBFileTypeInfo,//具体数据
};

@interface DBModel : NSObject
/**<#statements#>*/
@property (nonatomic) DBFileType fileType;
/**<#statements#>*/
@property (nonatomic, copy) NSString * fileContent;

/**<#statements#>*/
@property (nonatomic, strong) NSMutableArray * keyModels;

+ (NSArray *)parseLocalDBs;//加载本地库列表
+ (NSArray *)parseTableModelsByLocalDbName:(NSString *)dbName;//加载对应的库列表
+ (NSArray *)parseTableColumnModelsByTableName:(DBModel *)model;//解析为模型数组
+ (NSString *)parseTableColumnToJsonDataByTableName:(DBModel *)model;//解析为json
+ (NSString *)parseTableColumnToHtmlDataByTableName:(DBModel *)model;//解析为html
@end
