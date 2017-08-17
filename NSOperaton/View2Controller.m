//
//  View2Controller.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/19.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "View2Controller.h"
#import <Social/Social.h>

@interface View2Controller ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate>
/**<#statements#>*/
@property (nonatomic, strong) UITableView * tableview;
/**<#statements#>*/
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic,strong) UIDocumentInteractionController *documentInteractionController;
@end

@implementation View2Controller

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"系统分享-UIDocument",@"系统分享-UIActivity",@"系统分享-SLCompose"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    
    
}
- (void)addTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 0, 100, 20);
//    label.font = FONT(14);
    label.backgroundColor = [UIColor brownColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    [headerView addSubview:label];
    
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ident = @"ident";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            NSString *localPath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
            NSURL *pathUrl = [[NSURL alloc]initFileURLWithPath:localPath];
            
            // Initialize Document Interaction Controller
            self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:pathUrl];
            
            // Configure Document Interaction Controller
            [self.documentInteractionController setDelegate:self];
            
            // Present Open In Menu
//            [self.documentInteractionController presentPreviewAnimated:YES];
            [self.documentInteractionController presentOptionsMenuFromRect:[tableView frame] inView:self.view animated:YES];
        }break;
        case 1:{
            
            NSMutableArray *localPaths = [NSMutableArray array];
            for (int i = 1; i < 9; i ++) {
                NSString *localPath = [[NSBundle mainBundle] pathForResource:[@(i) stringValue] ofType:@"jpg"];
                NSData *localData = [NSData dataWithContentsOfFile:localPath];
                UIImage *localImage = [UIImage imageWithData:localData];
                if (localPath) {
                    [localPaths addObject:localImage];
                }
            }
            
            UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:localPaths applicationActivities:nil];
            //    UIActivityViewControllerCompletionHandler myBlock = ^(NSString *activityType,BOOL completed)
            //    {
            //        NSLog(@"调用分享的应用id :%@", activityType);
            //        if (completed)
            //        {
            //            NSLog(@"分享成功!");
            //        }
            //        else
            //        {
            //            NSLog(@"分享失败!");
            //        }
            //    };
            //    activity.completionHandler = myBlock;
            
            activity.excludedActivityTypes = @[UIActivityTypePostToTencentWeibo];//@[ UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
            
            if (activity) {
                [self presentViewController:activity animated:TRUE completion:nil];
            }
            
            //    if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
            //        [self presentViewController:activity animated:YES completion:nil];
            //    }
            //    else if([[UIDevice currentDevice].model isEqualToString:@"iPad"])
            //    {
            //        UIPopoverPresentationController *popover = activity.popoverPresentationController;
            //        if (popover) {
            //            popover.sourceView = self.sys2;
            //            popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
            //        }
            //        [self presentViewController:activity animated:YES completion:nil];
            //    }
            //    else
            //    {
            //        //do nothing
            //    }
            
        }break;
        case 2:{
            // 首先判断新浪分享是否可用
//            if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
//                return;
//            }
            
            // 创建控制器，并设置ServiceType
            SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
            // 添加要分享的图片
            for (int i = 1; i < 9; i ++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
                if (image) {
                    [composeVC addImage:image];
                }
            }
            
            // 添加要分享的文字
            [composeVC setInitialText:@"做人如果没有梦想,跟咸鱼有什么区别"];
            // 添加要分享的url
            [composeVC addURL:[NSURL URLWithString:@"http://blog.csdn.net/u011058732"]];
            // 弹出分享控制器
            [self presentViewController:composeVC animated:YES completion:nil];
            // 监听用户点击事件
            composeVC.completionHandler = ^(SLComposeViewControllerResult result){
                if (result == SLComposeViewControllerResultDone) {
                    NSLog(@"点击了发送");
                }
                else if (result == SLComposeViewControllerResultCancelled)
                {
                    NSLog(@"点击了取消");
                }
            };
        }break;
            
        default:
            break;
    }
}
#pragma mark Document Interaction Controller Delegate Methods
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

#pragma mark - 微信朋友圈压缩图片算法

//iOS-微信分享多张图片（UIActivityViewController多图分享和多图分享失败）
//http://blog.csdn.net/u014220518/article/details/53465631

//iOS-微信朋友圈图片压缩算法
//http://blog.csdn.NET/u014220518/article/details/58136932

#define KCompressibilityFactor 1280.00

#pragma mark - 压缩一张图片 最大宽高1280 类似于微信算法
- (UIImage *)getJPEGImagerImg:(UIImage *)image{
    CGFloat oldImg_WID = image.size.width;
    CGFloat oldImg_HEI = image.size.height;
    //CGFloat aspectRatio = oldImg_WID/oldImg_HEI;//宽高比
    if(oldImg_WID > KCompressibilityFactor || oldImg_HEI > KCompressibilityFactor){
        //超过设置的最大宽度 先判断那个边最长
        if(oldImg_WID > oldImg_HEI){
            //宽度大于高度
            oldImg_HEI = (KCompressibilityFactor * oldImg_HEI)/oldImg_WID;
            oldImg_WID = KCompressibilityFactor;
        }else{
            oldImg_WID = (KCompressibilityFactor * oldImg_WID)/oldImg_HEI;
            oldImg_HEI = KCompressibilityFactor;
        }
    }
    UIImage *newImg = [self imageWithImage:image scaledToSize:CGSizeMake(oldImg_WID, oldImg_HEI)];
    NSData *dJpeg = nil;
    if (UIImagePNGRepresentation(newImg)==nil) {
        dJpeg = UIImageJPEGRepresentation(newImg, 0.5);
    }else{
        dJpeg = UIImagePNGRepresentation(newImg);
    }
    return [UIImage imageWithData:dJpeg];
}
#pragma mark - 压缩多张图片 最大宽高1280 类似于微信算法
- (NSArray *)getJPEGImagerImgArr:(NSArray *)imageArr{
    NSMutableArray *newImgArr = [NSMutableArray new];
    for (int i = 0; i<imageArr.count; i++) {
        UIImage *newImg = [self getJPEGImagerImg:imageArr[i]];
        [newImgArr addObject:newImg];
    }
    return newImgArr;
}
#pragma mark - 压缩一张图片 自定义最大宽高
- (UIImage *)getJPEGImagerImg:(UIImage *)image compressibilityFactor:(CGFloat)compressibilityFactor{
    CGFloat oldImg_WID = image.size.width;
    CGFloat oldImg_HEI = image.size.height;
    //CGFloat aspectRatio = oldImg_WID/oldImg_HEI;//宽高比
    if(oldImg_WID > compressibilityFactor || oldImg_HEI > compressibilityFactor){
        //超过设置的最大宽度 先判断那个边最长
        if(oldImg_WID > oldImg_HEI){
            //宽度大于高度
            oldImg_HEI = (compressibilityFactor * oldImg_HEI)/oldImg_WID;
            oldImg_WID = compressibilityFactor;
        }else{
            oldImg_WID = (compressibilityFactor * oldImg_WID)/oldImg_HEI;
            oldImg_HEI = compressibilityFactor;
        }
    }
    UIImage *newImg = [self imageWithImage:image scaledToSize:CGSizeMake(oldImg_WID, oldImg_HEI)];
    NSData *dJpeg = nil;
    if (UIImagePNGRepresentation(newImg)==nil) {
        dJpeg = UIImageJPEGRepresentation(newImg, 0.5);
    }else{
        dJpeg = UIImagePNGRepresentation(newImg);
    }
    return [UIImage imageWithData:dJpeg];
}
#pragma mark - 压缩多张图片 自定义最大宽高
- (NSArray *)getJPEGImagerImgArr:(NSArray *)imageArr compressibilityFactor:(CGFloat)compressibilityFactor{
    NSMutableArray *newImgArr = [NSMutableArray new];
    for (int i = 0; i<imageArr.count; i++) {
        UIImage *newImg = [self getJPEGImagerImg:imageArr[i] compressibilityFactor:compressibilityFactor];
        [newImgArr addObject:newImg];
    }
    return newImgArr;
}
#pragma mark - 根据宽高压缩图片
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
