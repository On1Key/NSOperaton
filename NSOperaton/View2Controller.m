//
//  View2Controller.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/19.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "View2Controller.h"
#import <Social/Social.h>
#import "CusActivity.h"

@interface View2Controller ()<UITableViewDelegate,UITableViewDataSource,UIDocumentInteractionControllerDelegate>
/**<#statements#>*/
@property (nonatomic, strong) UITableView * tableview;
/**<#statements#>*/
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic,strong) UIDocumentInteractionController *documentInteractionController;
/**<#statements#>*/
@property (nonatomic, strong) UITextField * textfield;
@end

@implementation View2Controller

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"系统分享-UIDocument",@"系统分享-UIActivity",@"系统分享-SLCompose",@"系统分享-mov",@"系统分享-mp3"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    textfield.placeholder = @"占位文本";
    [titleView addSubview:textfield];
    self.navigationItem.titleView = titleView;
    self.view.backgroundColor = [UIColor whiteColor];
    _textfield = textfield;
    
//    [self canResignFirstResponder]
    
//    BOOL can = [textfield canBecomeFirstResponder];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        BOOL bec =[textfield becomeFirstResponder];
//    });
//    [textfield performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:1];
    
//    NSLog(@"===========================%d==%d",can,bec);
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_textfield  becomeFirstResponder];
}
- (void)addTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
//    if (@available(iOS 11.0, *)) {//避免滑动返回时table页面的偏移值问题
//        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    UILabel *label = [UILabel new];
    label.frame = headerView.bounds;
//    label.font = FONT(14);
    label.backgroundColor = [UIColor brownColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    [headerView addSubview:label];
    
    UIImage *oriImg = [UIImage imageNamed:@"myteam_bg_1"];
//    UIImage *recImg = [oriImg imageWithCornerRadius:100];
    CGRect imgBounds = CGRectMake(10, -9, 100, 30);
    UIImage *recImg = [UIImage createRoundedRectImage:oriImg size:CGSizeMake(80, 30) radius:15];
    
    NSArray *datas = @[@"文本1ad asd asdasdasd s",@"text2ssssssasdadasd8ad88888810",recImg,@"01进阶3asdfasdfsadfsadfsadfsdfsdfsdfsdfsdfsdfs",@"终结4asdfasdfasdfasdfsdfsdfsdf"];
    
    NSMutableAttributedString *finalAttStr = [NSMutableAttributedString new];
    for (id obj in datas) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSAttributedString *attStr = [self attributedStringWithText:(NSString *)obj textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:14] hasUnderlineStyle:NO lineSpacing:0 paragraphSpacing:0];
            [finalAttStr appendAttributedString:attStr];
        }else if ([obj isKindOfClass:[UIImage class]]){
            NSAttributedString *attImg = [self attributedStringWithImage:(UIImage *)obj imageBounds:imgBounds];
            [finalAttStr appendAttributedString:attImg];
        }
    }
    label.attributedText = finalAttStr;
    
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
//                UIImage *localImage = [UIImage imageWithData:localData];
                if (localPath) {
                    [localPaths addObject:localData];
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
            
//            activity.excludedActivityTypes = @[UIActivityTypePostToTencentWeibo];//@[ UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
            
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
        case 3:{
            NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mov"];
//            NSData *videoData = [NSData dataWithContentsOfFile:videoPath];
//            UIVideoEditorController *sss;
            NSArray *items = @[];
            if (videoPath) {
                items = @[videoPath];
            }
            
            CusActivity *cusAct1 = [[CusActivity alloc] initWithTitle:@"朋友圈" type:ActivityCusServiceWeixinFriends];
            CusActivity *cusAct2 = [[CusActivity alloc] initWithTitle:@"微信" type:ActivityCusServiceWeixin];
            NSArray *cusActs =  @[cusAct1,cusAct2];
            [cusActs enumerateObjectsUsingBlock:^(CusActivity  * _Nonnull act, NSUInteger idx, BOOL * _Nonnull stop) {
                act.urlString = @"http://www.baidu.com";
                act.shareDescription = @"分享内容";
                act.shareTitle = @"分享标题";
                act.image = [UIImage imageNamed:@"cash_ic_reason"];
            }];
            
            UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:cusActs];
//            activity.excludedActivityTypes = @[UIActivityTypePostToTencentWeibo];
            
            activity.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
                
            };
            
            if (activity) {
                [self presentViewController:activity animated:TRUE completion:nil];
            }
        }break;
        case 4:{
            NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"nuo" ofType:@"mp3"];
            NSData *videoData = [NSData dataWithContentsOfFile:videoPath];
            
            NSArray *items = @[];
            if (videoData) {
                items = @[videoData];
            }
            
            UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
//            activity.excludedActivityTypes = @[UIActivityTypePostToTencentWeibo];
            
            if (activity) {
                [self presentViewController:activity animated:TRUE completion:nil];
            }
        }break;
            
        default:
            break;
    }
}
#pragma mark Document Interaction Controller Delegate Methods
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

#pragma mark - att

// 1. 由文本生成attributedString
- (NSAttributedString *)attributedStringWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font hasUnderlineStyle:(BOOL)hasUnderLineStyle lineSpacing:(float)line paragraphSpacing:(float)paragraph {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSRange range = NSMakeRange(0, text.length);
    [paragraphStyle setLineSpacing:line];
    [paragraphStyle setParagraphSpacing:paragraph];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    
    if (hasUnderLineStyle) {
        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    }
    
    return attributedString;
}

// 2. 由图片生成attributedString
- (NSAttributedString *)attributedStringWithImage:(UIImage *)image imageBounds:(CGRect)bounds {
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    NSAttributedString *attachmentAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    
    return attachmentAttributedString;
}

// 3. 多个AttributedString拼接成一个resultAttributedString
- (NSAttributedString *)jointAttributedStringWithItems:(NSArray *)items {
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] init];
    
    for (int i = 0; i < items.count; i++) {
        if ([items[i] isKindOfClass:[NSAttributedString class]]) {
            [resultAttributedString appendAttributedString:items[i]];
        }
    }
    
    return resultAttributedString;
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
