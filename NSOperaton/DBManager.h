//
//  DBManager.h
//  NSOperaton
//
//  Created by Yang Mr on 2018/2/2.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
+ (instancetype)manager;
- (void)loadDBWithDBName:(NSString *)dbName;//加载对应的db文件
- (FMResultSet *)queryForTables;
- (FMResultSet *)queryForColumnsByTableName:(NSString *)tableName;
@end
