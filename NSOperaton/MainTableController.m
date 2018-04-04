//
//  MainTableController.m
//  NSOperaton
//
//  Created by Yang Mr on 2018/2/12.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import "MainTableController.h"

#import "ViewController.h"
#import "CustomOperation.h"

#import "NSMutableArray+safe.h"
#import "TableViewController.h"
#import "UIButton+Delay.h"
#import "UIButton+touch.h"
#import "FileTableViewController.h"

#import "View2Controller.h"
#import "TabBarController.h"
#import "DBTableController.h"

#import <SafariServices/SafariServices.h>
#import "CollectionController.h"

#define reuse @"mainCellReuseId"

@interface MainTableController ()<UIDocumentInteractionControllerDelegate,TLCityPickerDelegate>
/**<#statements#>*/
@property (nonatomic, strong) NSArray * dataSource;
@end

@implementation MainTableController

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"1、普通",
                        @"2、Table Images",
                        @"3、Table Files",
                        @"4、System Share",
                        @"5、Tabbar Test",
                        @"6、FMDB",
                        @"7、TLCityPickerController",
                        @"8、Animation Controller",
                        @"9、Safari",
                        @"10、Dynamic",
                        @"11、ReactiveCocoa",
                        @"12、Collection",
                        @"13、webviewToOc"];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuse];
    [self.tableView reloadData];
}

#pragma mark TLPickerCityController delegate
-(void)cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController{
    [cityPickerViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city{
    NSLog(@"%@", city.description);
    [cityPickerViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            ViewController *vc = [ViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 1:{
            TableViewController *table =  [TableViewController new];
            [self.navigationController pushViewController:table animated:YES];
        }break;
        case 2:{
            FileTableViewController *file = [[FileTableViewController alloc] init];
            [self.navigationController pushViewController:file animated:YES];
        }break;
        case 3:{
            
            [JsonModel parseData];
            
            View2Controller *vc = [View2Controller new];
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 4:{
            TabBarController *tabBar = [[TabBarController alloc] init];
            [self.navigationController pushViewController:tabBar animated:YES];
        }break;
        case 5:{
            DBTableController *db = [DBTableController new];
            [self.navigationController pushViewController:db animated:YES];
        }break;
        case 6:{
            TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
            [cityPickerVC setDelegate:self];
            
            // 设置定位城市
            cityPickerVC.locationCityID = @"1400010000";
            
            // 最近访问城市，如果不设置，将自动管理
            //  cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];
            
            // 热门城市，需手动设置
            //    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
            cityPickerVC.hotCitys = @[@"成都", @"深圳", @"上海", @"长沙", @"杭州", @"南京", @"徐州", @"北京"];
            
            // 支持push、present方式跳入，但需要有UINavigationController
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
            }];
            
            // 设置当前城市
            //    cityPickerVC.currentCity = @"深圳";
            // 设置热门城市
            //    cityPickerVC.hotCities = @[@"成都", @"深圳", @"上海", @"长沙", @"杭州", @"南京", @"徐州", @"北京"];
        }break;
        case 7:{
            NSLog(@"%s---%d---\n---%@",__func__,__LINE__,@"----0------");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"%s---%d---\n---%@",__func__,__LINE__,@"----2------");
            });
            
            BaseViewController *newVC = [[BaseViewController alloc] init];
            newVC.settingsInteractionController = [[NSClassFromString(interactionControllers[0]) alloc] init];
            newVC.settingsAnimationController = [[NSClassFromString(animationControllers[6]) alloc] init];
            [self presentViewController:newVC animated:YES completion:nil];
        }break;
        case 8:{
            SFSafariViewController *safari;
            if (@available(iOS 11.0,*)) {
                SFSafariViewControllerConfiguration *config = [[SFSafariViewControllerConfiguration alloc] init];
                config.entersReaderIfAvailable = YES;
                config.barCollapsingEnabled = YES;
                safari = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"] configuration:config];
            }else if (@available(iOS 9.0,*)){
                safari = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.baidu.com"] entersReaderIfAvailable:YES];
            }
            if (safari) {
                [self presentViewController:safari animated:YES completion:nil];
            }else{
                DLog(@"Not Supported")
            }
            
        }break;
        case 9:{
            View2Controller *vc = [View2Controller new];
            vc.controllerType = ControllerTypeDynamic;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 10:{
            View2Controller *vc = [View2Controller new];
            vc.controllerType = ControllerTypeReactiveCocoa;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 11:{
            CollectionController *collect = [[CollectionController alloc] init];
            [self.navigationController pushViewController:collect animated:YES];
        }break;
        case 12:{
            View2Controller *vc = [View2Controller new];
            vc.controllerType = ControllerTypeWebviewToOc;
            [self.navigationController pushViewController:vc animated:YES];
        }break;
        case 13:{
            
        }break;
        case 14:{
            
        }break;
            
        default:
            break;
    }
}
@end
