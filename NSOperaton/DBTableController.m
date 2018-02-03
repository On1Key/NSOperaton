//
//  DBTableController.m
//  NSOperaton
//
//  Created by Yang Mr on 2018/2/2.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import "DBTableController.h"
#import "DBModel.h"
#import "WebController.h"

#define reuse_id @"db_reuse_id"

@interface DBTableController ()

@end

@implementation DBTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuse_id];
    
    //当且仅当没有数据源，并且不是表页面，才会初始化表命页面列表
    if (!_dataModels && ![[self.navigationController.viewControllers lastObject] isKindOfClass:NSClassFromString(@"ViewController")]) {
        self.title = @"root";
        _dataModels = [DBModel parseLocalDBs].mutableCopy;
    }
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataModels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse_id];
    DBModel *model = _dataModels[indexPath.row];
    cell.textLabel.text = model.fileContent;
    cell.textLabel.numberOfLines = 0;
    switch (model.fileType) {
        case DBFileTypeDB:
        case DBFileTypeTable:
        case DBFileTypeColumn:{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }break;
        default:
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DBModel *model = _dataModels[indexPath.row];
    switch (model.fileType) {
        case DBFileTypeDB:{
            DBTableController *table = [DBTableController new];
            table.title = @"table";
            table.dataModels = [DBModel parseTableModelsByLocalDbName:model.fileContent].mutableCopy;
            [self.navigationController pushViewController:table animated:YES];
        }break;
        case DBFileTypeTable:{
            WebController *web = [WebController new];
            web.title = model.fileContent;
            web.localHtmlData = [DBModel parseTableColumnToHtmlDataByTableName:model];
            [self.navigationController pushViewController:web animated:YES];
//            DBTableController *table = [DBTableController new];
//            table.title = @"column";
//            table.dataModels = [DBModel parseTableColumnModelsByTableName:model].mutableCopy;
//            [self.navigationController pushViewController:table animated:YES];
        }break;
        case DBFileTypeColumn:{
            
//            DBTableController *table = [DBTableController new];
//            table.dataModels = model.keyModels;
//            table.title = @"info";
//            [self.navigationController pushViewController:table animated:YES];
        }break;
            
        default:
            break;
    }
}

@end
