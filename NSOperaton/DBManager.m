//
//  DBManager.m
//  NSOperaton
//
//  Created by Yang Mr on 2018/2/2.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import "DBManager.h"

@interface DBManager()
/**<#statements#>*/
@property (nonatomic, strong) FMDatabase * db;
@end

@implementation DBManager

static DBManager *manager;
+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc] init];
    });
    return manager;
}
//- (FMDatabase *)db{
//    if (!_db) {
//        NSArray *localDBs = @[@"Cache.db",@"jkdb.sqlite",@"test.db"];
//        
//        FMDatabase* database = [FMDatabase db];
//        _db = database;
//    }
//    return _db;
//}
- (void)loadDBWithDBName:(NSString *)dbName{
    NSString* dbPath = [[NSBundle mainBundle]pathForResource:dbName ofType:nil];
    if (dbPath) {
        self.db = [FMDatabase databaseWithPath:dbPath];
    }
}
- (FMResultSet *)queryForTables{
    FMDatabase* database = self.db;
    FMResultSet *resultSet;
    if ( ![ database open ] )
    {
        return resultSet;
    }
    return [database executeQuery:@"SELECT * FROM sqlite_master where type='table';"];
}
- (FMResultSet *)queryForColumnsByTableName:(NSString *)tableName{
    FMResultSet *resultSet;
    if (!tableName) {
        return resultSet;
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    resultSet = [self.db executeQuery:sql];
    return resultSet;
}


@end
