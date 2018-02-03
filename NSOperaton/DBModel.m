//
//  DBModel.m
//  NSOperaton
//
//  Created by Yang Mr on 2018/2/2.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import "DBModel.h"
#import "DBManager.h"
@implementation DBModel

- (NSMutableArray *)keyModels{
    if (!_keyModels) {
        _keyModels = [NSMutableArray array];
    }
    return _keyModels;
}
+ (NSArray *)parseLocalDBs{
    NSArray *localDBs = @[@"Cache.db",@"jkdb.sqlite",@"test.db"];
    NSMutableArray *data = [NSMutableArray array];
    for (NSString *dbName in localDBs) {
        DBModel *model = [DBModel new];
        model.fileType = DBFileTypeDB;
        model.fileContent = dbName;
        [data addObject:model];
    }
    return data;
}
+ (NSArray *)parseTableModelsByLocalDbName:(NSString *)dbName{
    DBManager *manager = [DBManager manager];
    [manager loadDBWithDBName:dbName];
    FMResultSet *res = [manager queryForTables];
    if (!res) {
        return nil;
    }
    
    NSMutableArray *tableNames = [NSMutableArray array];
    int index = 0;
    while ([res next]) {
        NSString *str0 = [res stringForColumnIndex:index];
        DBModel *model = [DBModel new];
        model.fileType = DBFileTypeTable;
        model.fileContent = str0;
        NSLog(@"+++======%@",str0);
        index += 1;
        [tableNames addObject:model];
    }
    return tableNames;
}
+ (NSString *)parseTableColumnToJsonDataByTableName:(DBModel *)model{
    if (!model || model.fileType != DBFileTypeTable) {
        return nil;
    }
    DBManager *manager = [DBManager manager];
    FMResultSet *res = [manager queryForColumnsByTableName:model.fileContent];
    NSMutableDictionary *columnMap = res.columnNameToIndexMap;
    NSMutableArray *finalData = @[].mutableCopy;
    NSInteger allKeysIndex = columnMap.allKeys.count;
    while ([res next]) {
        NSMutableDictionary *jsonModel = @{}.mutableCopy;
        for (int i = 0; i < allKeysIndex; i ++) {
            NSString *key = columnMap.allKeys[i];
            NSString *value = [res stringForColumn:key];
            [jsonModel setObject:value forKey:key];
        }
        [finalData addObject:jsonModel];
    }
    return [NSString stringWithFormat:@"%@",finalData];
}
+ (NSString *)parseTableColumnToHtmlDataByTableName:(DBModel *)model{
    if (!model || model.fileType != DBFileTypeTable) {
        return nil;
    }
    DBManager *manager = [DBManager manager];
    FMResultSet *res = [manager queryForColumnsByTableName:model.fileContent];
    NSMutableDictionary *columnMap = res.columnNameToIndexMap;
    
    //写入html的列表头标签
    NSString *htmlData = @"<html><head> \
        <style type='text/css'>\
            thead {color:green}\
            tbody {color:black;height:50px}\
            tfoot {color:red}\
        </style>\
    <head><body><table border='1'>";
    htmlData = [htmlData stringByAppendingFormat:@"<caption>%@</caption><thead><tr>",model.fileContent];
    NSInteger allKeysIndex = columnMap.allKeys.count;
    for (int i = 0; i < allKeysIndex; i ++) {
        NSString *th = [NSString stringWithFormat:@"<th>%@</th>",columnMap.allKeys[i]];
        htmlData = [htmlData stringByAppendingFormat:@"%@",th];
    }
    htmlData = [htmlData stringByAppendingFormat:@"</tr></thead><tbody>"];
    
    while ([res next]) {
        
        NSString *tr = @"<tr>";
        for (int i = 0; i < allKeysIndex; i ++) {
            NSString *key = columnMap.allKeys[i];
            NSString *value = [res stringForColumn:key];
            NSString *td = [NSString stringWithFormat:@"<td>%@</td>",value];
            tr = [tr stringByAppendingString:td];
        }
        tr = [tr stringByAppendingString:@"</tr>"];
        htmlData = [htmlData stringByAppendingString:tr];
    }
    return [htmlData stringByAppendingFormat:@"</tbody></table></body><html>"];
}
+ (NSArray *)parseTableColumnModelsByTableName:(DBModel *)model{
    if (!model || model.fileType != DBFileTypeTable) {
        return nil;
    }
    DBManager *manager = [DBManager manager];
    FMResultSet *res = [manager queryForColumnsByTableName:model.fileContent];
    NSMutableDictionary *columnMap = res.columnNameToIndexMap;
    NSMutableArray *tableNames = [NSMutableArray array];
    int index = 0;
    while ([res next]) {
        
        NSInteger allKeysIndex = columnMap.allKeys.count;
        DBModel *model = [DBModel new];
        model.fileType = DBFileTypeColumn;
        model.fileContent = [@(index) stringValue];
        for (int i = 0; i < allKeysIndex; i ++) {
            NSString *key = columnMap.allKeys[i];
            NSString *value = [res stringForColumn:key];
            DBModel *subModel = [DBModel new];
            subModel.fileType = DBFileTypeInfo;
            subModel.fileContent = [NSString stringWithFormat:@"k=%@\nv=%@",key,value];
            [model.keyModels addObject:subModel];
        }
        index += 1;
        [tableNames addObject:model];
    }
    return tableNames;
}

@end
