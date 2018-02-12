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
    
    // -------------------异步同时完成测试1------------------
    NSMutableArray *groArr0 = [NSMutableArray array];
    NSMutableArray *groArr1 = [NSMutableArray array];
    dispatch_group_t group_t = dispatch_group_create();
    dispatch_queue_t queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group_t, queue_t, ^{
        NSLog(@"002-A");
        for (int i = 0; i < 2; i ++) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [groArr0 addObject:@(i)];
                NSLog(@"001=A=%@",groArr0);
            });
        }
    });
    dispatch_group_notify(group_t, dispatch_get_main_queue(), ^{
        NSLog(@"002-B");
        for (int i = 0; i < 3; i ++) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [groArr1 addObject:@(i)];
                NSLog(@"002=B=%@",groArr1);
            });
        }
    });
    // ------------------异步同时完成测试2-------------------
    dispatch_queue_t queue =  dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"A");
    });
    dispatch_async(queue, ^{
        NSLog(@"C");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"拿到了A的值");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"D");
    });
    dispatch_async(queue, ^{
        NSLog(@"E");
    });dispatch_async(queue, ^{
        NSLog(@"F");
    });
    // ------------------异步同时完成测试3-------------------
    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __block dispatch_group_t groupEnter;
    NSMutableArray *arr301 = [NSMutableArray array];
    NSMutableArray *arr302 = [NSMutableArray array];
    dispatch_async(queue3, ^{
        
        groupEnter = dispatch_group_create();
        
        dispatch_group_async(groupEnter, queue3, ^{
            dispatch_group_enter(groupEnter);
            NSLog(@"003------A");
            for (int i = 0; i < 2; i ++) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [arr301 addObject:@(i)];
                    NSLog(@"003------A=%@",arr301);
                });
            }
            
        });
        dispatch_group_async(groupEnter, queue3, ^{
            dispatch_group_enter(groupEnter);
            NSLog(@"003-------B");
            for (int i = 0; i < 3; i ++) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [arr302 addObject:@(i)];
                    NSLog(@"003-------B=%@",arr302);
                });
            }
        });
        dispatch_group_notify(groupEnter, queue3, ^{
            NSLog(@"003--------end:==%@==%@",arr301,arr302);
        });
    });
    // -----------------------------------
    
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
