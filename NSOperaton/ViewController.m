//
//  ViewController.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/4/20.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "ViewController.h"
#import "CustomOperation.h"
#import <WebKit/WebKit.h>
#import "NSMutableArray+safe.h"
#import "TableViewController.h"
#import "UIButton+Delay.h"
#import "UIButton+touch.h"
#import "FileTableViewController.h"

#import "View2Controller.h"
#import "TabBarController.h"
#import "DBTableController.h"
//#import "AppDelegate.h"
//#import ""
//#import "CEHorizontalSwipeInteractionController.h"
//#import "CEFoldAnimationController.h"
//#import "CEHorizontalSwipeInteractionController.h"


//#import <FFmpeg/libavformat/avformat.h>

@interface ViewController ()
/**<#statements#>*/
@property (nonatomic, strong) NSOperationQueue * parseQueue;
/**<#statements#>*/
@property (nonatomic, strong) UIWebView * webView;
/**<#statements#>*/
@property (nonatomic, strong) WKWebView * wkWebview;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

/**<#statements#>*/
@property (nonatomic) NSInteger page;

/**<#statements#>*/
//@property (nonatomic, strong) CEFlipAnimationController * animationController;
///**<#statements#>*/
//@property (nonatomic, strong) CEHorizontalSwipeInteractionController * interactionController;
/**<#statements#>*/
@property (nonatomic) BOOL showLargeEnable;
@end

@implementation ViewController

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSInteger num = arc4random()%2;
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
////    if (num == 0) {
////        self.webView.hidden = NO;
////        self.wkWebview.hidden = YES;
////        [self.webView loadRequest:req];
////    }else{
//        self.webView.hidden = YES;
//        self.wkWebview.hidden = NO;
//        [self.wkWebview loadRequest:req];
////    }
//
//
//}

#pragma mark - other

- (void)numberFormatAction{
    long long card  = 6228480022222434444;
    long long idNo = 130125199112017312;
    NSNumber *number = [[NSNumber alloc] initWithLongLong:idNo];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setPositiveFormat:@"####,####"];
//    [formatter setPositiveFormat:@"###,###,####,####,####"];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:4];
    [formatter setGroupingSeparator:@" "];
//    NSString *scitentificStr = [NSNumberFormatter localizedStringFromNumber:number numberStyle:NSNumberFormatterCurrencyAccountingStyle];
    NSString *scienceStr = [formatter stringFromNumber:number];
    DLog(@"%@",scienceStr)
    
}
#pragma mark -
#pragma mark JPG格式的图片 根据图片部份数据得到图片的size
+ (CGSize)downloadJpgImage:(NSString*)strUrl
{
    NSLog(@"________calculate_download_imgSize_time_start");
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strUrl]];
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"________calculate_download_imgSize_time_end");
    return [self jpgImageSizeWithHeaderData:data];
}

+ (CGSize)jpgImageSizeWithHeaderData:(NSData *)data
{
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSInteger imgIndex = arc4random()%2;
    NSString *imgUrlStr = @[@"http://img.zcool.cn/community/018d4e554967920000019ae9df1533.jpg@900w_1l_2o_100sh.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2239146502,165013516&fm=27&gp=0.jpg"][imgIndex];
    NSLog(@"jpg__size==%ld=%@",imgIndex,NSStringFromCGSize([ViewController downloadJpgImage:imgUrlStr]));
    
    //默认timer在主runloop中运行，如果需要在所有loop（包括scrollview滚动的loop）运行，需要额外设置
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"Timer Running -----");
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    NSArray *proArr =  [AnalysisManager runningProcesses];
    NSLog(@"%@",proArr);
//    _animationController = [[CEFlipAnimationController alloc] init];
//    _interactionController = [[CEHorizontalSwipeInteractionController alloc] init];
    
//    av_register_all();
    
//    NSMutableArray *testEnumToDeleteArr = @[@"12",@"",@"1212",@"",@"212",@"",@"qwq"].mutableCopy;
//    DLog(@"%@",testEnumToDeleteArr);
//    for (NSString *str in testEnumToDeleteArr) {
//        if ([str isEqualToString:@""]) {
//            [testEnumToDeleteArr removeObject:str];
//        }
//    }
//    DLog(@"%@",testEnumToDeleteArr);
    
    UIView *redView = [[UIView alloc] init];
    redView.tag = 1;
    redView.backgroundColor = [UIColor redColor];
    
    UIView *greenView = [[UIView alloc] init];
    greenView.tag = 2;
    greenView.backgroundColor = [UIColor greenColor];
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.tag = 3;
    yellowView.backgroundColor = [UIColor yellowColor];
    
    UIView *brownView = [[UIView alloc] init];
    brownView.tag = 4;
    brownView.backgroundColor = [UIColor brownColor];
    
    UITapGestureRecognizer *redTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStackViewAction:)];
    [redView addGestureRecognizer:redTap];
    UITapGestureRecognizer *greenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStackViewAction:)];
    [greenView addGestureRecognizer:greenTap];
    UITapGestureRecognizer *yellowTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStackViewAction:)];
    [yellowView addGestureRecognizer:yellowTap];
    UITapGestureRecognizer *brownTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStackViewAction:)];
    [brownView addGestureRecognizer:brownTap];
    
    FDStackView *stackView = [[FDStackView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100)];
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillProportionally;
    stackView.spacing = 10;
    stackView.alignment = UIStackViewAlignmentFill;
//    stackView
    [self.view addSubview:stackView];
    [stackView addArrangedSubview:redView];
    [stackView addArrangedSubview:greenView];
    [stackView addArrangedSubview:yellowView];
    [stackView addArrangedSubview:brownView];
    
    CGFloat SCREENWIDTH = (SCREEN_WIDTH - stackView.spacing * (stackView.arrangedSubviews.count - 1))/stackView.arrangedSubviews.count;
        
//    [stackView addConstraints:@[[NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:(SCREENWIDTH)],[NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:100],[NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:(SCREENWIDTH)],[NSLayoutConstraint constraintWithItem:greenView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0.5 constant:100],[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:(SCREENWIDTH)],[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(100)],[NSLayoutConstraint constraintWithItem:brownView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:(SCREENWIDTH)],[NSLayoutConstraint constraintWithItem:brownView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:(100)]]];
    
    
    [self numberFormatAction];
    
    NSString *canStr = @"23.7 small cases 111 of bananas";
    NSInteger newPage = _page - 1;
    canStr = [NSString stringWithFormat:@"%@-%ld-%ld",canStr,_page,newPage];
    
    
    long sum = [CalculateManager new].sumBlock(12,11);
    
    DLog(@"%ld",[CalculateManager new].add(1).add(2).add(100).result);
    
    NSAttributedString *numAtt = [canStr replaceOriginalContainNumStringFromAttribute:@{} toAttribute:@{NSForegroundColorAttributeName:[UIColor brownColor]}];
    NSString * htmlString = @"<html><body> Some html string,Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state,<font size =\"10\" color =\"brown\">Use this method to release</font> shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface. \n <font size=\"22\" color=\"red\">This is some text!</font> </body></html>";
    NSAttributedString * htmlAtt = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    NSMutableAttributedString *allAtt = [[NSMutableAttributedString alloc] init];
    [allAtt appendAttributedString:numAtt];
    [allAtt appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
//    [allAtt appendAttributedString:htmlAtt];
    _numLabel.attributedText = allAtt;
//    DLog(@"\n--------------------------\n%@",[self findNumFromStr:canStr]);
    
    
    
    NSArray *tryArr = @[@"1",@"2",@"3",@"4"];
    
    NSString *obj;
    @try {
        obj = tryArr[4];
    } @catch (NSException *exception) {
        DLog(@"%@",exception.description);
//        obj = tryArr[1];
    } @finally {
        DLog(@"%@",obj);
    }
    
    
    
    
    NSArray *testarr = @[@"1212",@{@"12":@"12"},@[@"12"],@"1212",@"qwqw",@"1212",@"1212",@"121",@"1212"];
    for (int i = 0; i < testarr.count; i ++) {
        
        id obj = testarr[i];
        NSLog(@"----%@",obj);
        switch (i % 2) {
            case 0:
                
                if ([obj isKindOfClass:[NSString class]]) {
                    
                }else if ([obj isKindOfClass:[NSDictionary class]]){
                    
                }else if ([obj isKindOfClass:[NSArray class]]){
                    continue;
                }
                NSLog(@"%@",obj);
                
                break;
                
            default:
                if ([obj isKindOfClass:[NSString class]]) {
                    
                }else if ([obj isKindOfClass:[NSDictionary class]]){
                    
                }else if ([obj isKindOfClass:[NSArray class]]){
                    continue;
                }
                NSLog(@"%@",obj);
                break;
        }
        
    }
    
    NSString *name = NSLocalizedString(@"ReadName", nil);
    DLog(@"\n%@\n%@\n%@",name,BASE_URL,BASE_SHARE_URL);
    
    NSString *str = @"中午能“撒大声地”";
    UILabel *label = [UILabel new];
    label.text = str;
    [self.view addSubview:label];
    DLog(@"%@==%@",str,label.text);
    
    [self setIconOriginalUrls:@[@"1212",@"wqeqweq",@"1213123"]];
    
    NSString *checkStr = @"12314212.121";
    NSString *regexStr = @"(?<=\\d)(?<!\\.\\d*)(?=(\\d{3})+(\\.|$))";
//    NSPredicate *dicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexStr];
//    
//    [dicate ]
    
    NSRegularExpression *express = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *result = [express firstMatchInString:checkStr options:0 range:NSMakeRange(0, [checkStr length])];
    
    
    
    NSLog(@"%@\n====%@==%@==%@:%@==%@==%@",NSTemporaryDirectory(),[self toExponent:123123123 rms:4],[self ChangeNumberFormat:checkStr],result,[checkStr substringWithRange:result.range],[self positiveFormat:checkStr count:2],[self positiveFormat:[@"12qw3,1q2,120.1200001" stringByReplacingOccurrencesOfString:@"," withString:@""] count:1]);
    
    
    NSInteger count = 10;
    NSInteger ssss = 2;
    count = ssss;
    ssss = 0;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:nil];
    [arr addObject:@"121"];
    NSLog(@"%s---%d---\n---%ld==%ld==%@",__func__,__LINE__,ssss,count,arr);

//    [@"" isEqualToString:]
    
    UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    
    
    if (([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)) {
        UIUserNotificationType myType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        UIUserNotificationSettings *mySetting = [UIUserNotificationSettings settingsForTypes:myType categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySetting];
    }else {
        UIRemoteNotificationType myType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myType];
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:10];
    
    [self operationTEst];
    
}
- (void)changeStackViewAction:(UIGestureRecognizer*)ges{
    UIView *view = ges.view;
    UIStackView *stackView = (UIStackView *)view.superview;
    _showLargeEnable = !_showLargeEnable;
    
    if (_showLargeEnable) {
//            stackView.arrangedSubviews[1].hidden = YES;
//            stackView.arrangedSubviews[2].hidden = YES;
//            stackView.arrangedSubviews[3].hidden = YES;
//        [stackView removeArrangedSubview:stackView.arrangedSubviews[1]];
//        [stackView.subviews[1] removeFromSuperview];
//        [stackView removeArrangedSubview:stackView.arrangedSubviews[1]];
//        [stackView.subviews[1] removeFromSuperview];
//        [stackView removeArrangedSubview:stackView.arrangedSubviews[1]];
//        [stackView.subviews[1] removeFromSuperview];
        for (UIView *subview in stackView.arrangedSubviews) {
            if (![subview isEqual:view]) {
                [stackView removeArrangedSubview:subview];
            }
        }
        [UIView animateWithDuration:0.5 animations:^{
            [stackView layoutIfNeeded];
        }];
    }else{
        for (int i = 0; i < 3; i ++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = COLOR_RANDOM;
            [stackView addArrangedSubview:view];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeStackViewAction:)];
            [view addGestureRecognizer:tap];
        }
        [UIView animateWithDuration:0.5 animations:^{
//            stackView.arrangedSubviews[1].hidden = NO;
//            stackView.arrangedSubviews[2].hidden = NO;
//            stackView.arrangedSubviews[3].hidden = NO;
//            [stackView reloadInputViews];
            [stackView layoutIfNeeded];
        } completion:^(BOOL finished) {
            for (int i = 0; i < stackView.arrangedSubviews.count; i ++) {
                UIView *subv = stackView.arrangedSubviews[i];
                subv.tag = i;
            }
        }];
        
        
    }
    
    return;
    [UIView animateWithDuration:0.5 animations:^{
        for (UIView *subview in stackView.arrangedSubviews) {
            if (_showLargeEnable) {
                if ([view isEqual:subview]) {
                    subview.hidden = NO;
                }else{
                    subview.hidden = YES;
                }
            }else{
                subview.hidden = NO;
            }
            
        }
    }];
    return;
    
    switch (view.tag) {
        case 1:{
            int curType = stackView.axis;
            if (curType >= 2) {
                curType = 0;
            }
            stackView.axis = curType;
        }break;
        case 2:{
            int curType = stackView.distribution;
            if (curType >= 5) {
                curType = 0;
            }
            stackView.distribution = curType;
        }break;
        case 3:{
            int curType = stackView.alignment;
            if (curType >= 8) {
                curType = 0;
            }
            stackView.alignment = curType;
        }break;
            
        default:
            break;
    }
    [stackView reloadInputViews];
}
- (void)blockDispatchTest{
    // Do any additional setup after loading the view, typically from a nib.
    //    NSInteger callBackCount = 2;
    __block NSInteger blockCallBackCount = 2;
    /**两个bool值用于保存保存事件的回调结果*/
    //    BOOL imageOrVideoSaveSuccessState = NO;
    //    BOOL productQrSaveSuccessState = NO;
    __block BOOL blockImageOrVideoSaveSuccess = NO;
    __block BOOL blockProductQrSaveSuccess = NO;
    
    void(^call)(BOOL imageFinish,BOOL textFinish) = ^(BOOL imageFinish,BOOL textFinish){
        blockCallBackCount --;
        NSLog(@"--------");
        if (blockCallBackCount == 0) {
            NSMutableArray *arr = @[].mutableCopy;
            if (imageFinish) {
                [arr addObject:@"imageFinish"];
            }
            if (textFinish) {
                [arr addObject:@"textFinish"];
            }
            NSLog(@"%@",arr);
        }
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        blockImageOrVideoSaveSuccess = YES;
        call(blockImageOrVideoSaveSuccess,blockProductQrSaveSuccess);
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        blockProductQrSaveSuccess = YES;
        call(blockImageOrVideoSaveSuccess,blockProductQrSaveSuccess);
    });
    
    
    //    NSBlockOperation *ob1 = [NSBlockOperation blockOperationWithBlock:^{
    //
    //        [ob1 cancel];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"执行第1.1次操作，线程：%@", [NSThread currentThread]);
    //            [ob1 start];
    //        });
    //
    //        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    //    }];
    //
    //    [self.parseQueue addOperation:ob1];
    //
    //    NSBlockOperation *ob2 = [NSBlockOperation blockOperationWithBlock:^{
    //
    //        [ob2 cancel];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"执行第1.1次操作，线程：%@", [NSThread currentThread]);
    //            [ob2 start];
    //        });
    //
    //        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    //    }];
    //
    //    [self.parseQueue addOperation:ob2];
    //
    //    NSBlockOperation *ob3 = [NSBlockOperation blockOperationWithBlock:^{
    //
    //        [ob3 cancel];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"执行第1.1次操作，线程：%@", [NSThread currentThread]);
    //            [ob3 start];
    //        });
    //
    //        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    //    }];
    //
    //    [self.parseQueue addOperation:ob3];
    //
    //    NSBlockOperation *ob4 = [NSBlockOperation blockOperationWithBlock:^{
    //
    //        [ob4 cancel];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            NSLog(@"执行第1.1次操作，线程：%@", [NSThread currentThread]);
    //            [ob4 start];
    //        });
    //
    //        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    //    }];
    //
    //    [self.parseQueue addOperation:ob4];
    //
    //
    //    [self.parseQueue setSuspended:NO];
    //
    //
    //    NSMutableArray *arr = @[@"1",@"2",@"3",@"4",@"5"].mutableCopy;
    //    for (NSString *str in arr) {
    //        NSLog(@"-----");
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [arr removeObject:str];
    //            NSLog(@"%@",arr);
    //        });
    //    }
}
- (void)operationTEst{
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(2);
        for (int i = 0; i < 5; i ++) {
            DLog(@"Thread1:%d",i);
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        sleep(4);
        for (int i = 0; i < 5; i ++) {
            DLog(@"Thread2:%d",i);
        }
    }];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
    }];
    
    SDWebImageDownloader *loader = [SDWebImageDownloader sharedDownloader];
    [loader downloadImageWithURL:nil options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
    }];
    
    [self.parseQueue addOperation:op1];
    [self.parseQueue addOperation:op2];
    
    [op1 setQueuePriority:NSOperationQueuePriorityLow];
    [op2 setQueuePriority:NSOperationQueuePriorityHigh];
    
    [op1 addDependency:op2];
    
    [self.parseQueue setSuspended:NO];
    
    for (int i = 0; i < 5; i ++) {
        DLog(@"Main thread:%d",i);
    }
    
}
//KVO,观察parseQueue是否执行完
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == self.parseQueue && [keyPath isEqualToString:@"operations"])
    {
        if (0 == self.parseQueue.operations.count)
        {
            NSLog(@"parse finished");
            //other operation
//            [_parseQueue setSuspended:YES];
            
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (UIWebView *)webView{
    if (!_webView) {
        UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:webview];
        _webView = webview;
    }
    return _webView;
}
- (WKWebView *)wkWebview{
    if (!_wkWebview) {
        WKWebView *web = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:web];
        _wkWebview = web;
    }
    return _wkWebview;
}

- (NSOperationQueue *)parseQueue
{
    if (nil == _parseQueue)
    {
        _parseQueue = [[NSOperationQueue alloc] init];
        _parseQueue.maxConcurrentOperationCount = 3;
        [_parseQueue setSuspended:YES];
        //[_parseQueue setMaxConcurrentOperationCount:1];
        [_parseQueue addObserver:self
                      forKeyPath:@"operations"
                         options:0
                         context:nil];
    }
    
    return _parseQueue;
}
- (void)setIconOriginalUrls:(NSArray *)iconOriginalUrls{
    
    NSMutableArray *thumbUrls = [NSMutableArray array];
    NSString *iconStr = @"";
    
    for (int i = 0; i < iconOriginalUrls.count; i ++) {
        NSString *url = iconOriginalUrls[i];
        [thumbUrls addObject:url];
        if (i == 0) {
            iconStr = url;
        }else{
            iconStr = [NSString stringWithFormat:@"%@,%@",iconStr,url];
        }
    }
    
    NSLog(@"%@\n%@",iconStr,iconOriginalUrls);
}
/*
 科学计数法，保留n个有效值
 */

-(NSString *) toExponent:(double)d rms:(unsigned)n
{
    if(n==0)
    {
        return nil;
    }
    CFLocaleRef currentLocale = CFLocaleCopyCurrent();
    CFNumberFormatterRef customCurrencyFormatter = CFNumberFormatterCreate
    (NULL, currentLocale, kCFNumberFormatterCurrencyStyle);
    NSString *s_n = @"#";
    if(n > 1)
    {
        for(int j = 0; j < n; j++)
        {
            NSString *temp = s_n;
            if(j == 0)
            {
                s_n = [temp stringByAppendingString:@"."];
            }
            else
            {
                s_n = [temp stringByAppendingString:@"0"];
            }
            
        }
        
    }
    CFNumberFormatterSetFormat(customCurrencyFormatter, (CFStringRef)s_n);
    
    double i=1;
    int exponent = 0;
    while (1) {
        i = i*10;
        exponent++;
        if(d < i)
        {
            break;
        }
    }
    double n1 = d * 10 / i;
    
    CFNumberRef number1 = CFNumberCreate(NULL, kCFNumberDoubleType, &n1);
    CFStringRef string1 = CFNumberFormatterCreateStringWithNumber
    (NULL, customCurrencyFormatter, number1);
    
    NSString * result = [NSString stringWithFormat:@"%s E%d",CFStringGetCStringPtr(string1, CFStringGetSystemEncoding()),exponent];
    
    CFRelease(currentLocale);
    CFRelease(customCurrencyFormatter);
    CFRelease(number1);
    CFRelease(string1);
    
    return result;
    
}
-(NSString *)ChangeNumberFormat:(NSString *)num
{
    if (num == nil) {
        return @"";
    }
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}
- (NSString *)positiveFormat:(NSString *)text count:(int)count{
    //如果已经是千分位的数值，取消原有的千分位模式
    text = [text stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    NSString *floatStr;
    floatStr = @"";
    if (count != 0) {
        floatStr = @".";
        for (int i = 0; i < count; i ++) {
            floatStr = [floatStr stringByAppendingString:@"0"];
        }
    }
    
    if(!text || [text floatValue] == 0){
        if (count == 0) {
            return @"0";
        }else{
            return [@"0" stringByAppendingString:floatStr];
        }
    }else{
        
        NSString *format = @",###";
        if (count != 0) {
            format = [format stringByAppendingString:floatStr];
        }
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:format];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"";
}


@end
