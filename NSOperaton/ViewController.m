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
//#import "AppDelegate.h"
//#import ""
//#import "CEHorizontalSwipeInteractionController.h"
//#import "CEFoldAnimationController.h"
//#import "CEHorizontalSwipeInteractionController.h"


//#import <FFmpeg/libavformat/avformat.h>

@interface ViewController ()<UIDocumentInteractionControllerDelegate>
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
@end

@implementation ViewController

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSInteger num = arc4random()%2;
//    NSURL *url = [NSURL URLWithString:@"http://121.17.126.24:10087/AppCorrect/CorrectTask?taskId=16&stuId=21&userId=59&schCode=sszx&teaId=53"];
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
- (void)jump{
    TableViewController *table =  [TableViewController new];
    
//    NavigationController *navi = (NavigationController *)self.navigationController;
    
//    self.settingsInteractionController = [[CEHorizontalSwipeInteractionController alloc] init];
//    self.settingsAnimationController = [[CEFoldAnimationController alloc] init];
//    DLog(@"%@",self.navigationController);
    [self.navigationController pushViewController:table animated:YES];
//    [self.navigationController presentViewController:[[UINavigationController alloc] initWithRootViewController:table] animated:YES completion:nil];
    
}
- (void)fileReviewAction{
    FileTableViewController *file = [[FileTableViewController alloc] init];
    [self.navigationController pushViewController:file animated:YES];
}
- (void)setting{
    
    [JsonModel parseData];
    
    View2Controller *vc = [View2Controller new];
    [self.navigationController pushViewController:vc animated:YES];
    
//    SettingsViewController *setting = [[SettingsViewController alloc] init];
//    [self.navigationController pushViewController:setting animated:YES];
}



#pragma mark - other


- (IBAction)btntap:(id)sender {
    NSLog(@"%s---%d---\n---%@",__func__,__LINE__,@"----0------");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%s---%d---\n---%@",__func__,__LINE__,@"----2------");
    });
    
    BaseViewController *newVC = [[BaseViewController alloc] init];
    newVC.settingsInteractionController = [[NSClassFromString(interactionControllers[0]) alloc] init];
    newVC.settingsAnimationController = [[NSClassFromString(animationControllers[6]) alloc] init];
    [self presentViewController:newVC animated:YES completion:nil];
}
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *proArr =  [AnalysisManager runningProcesses];
    NSLog(@"%@",proArr);
//    _animationController = [[CEFlipAnimationController alloc] init];
//    _interactionController = [[CEHorizontalSwipeInteractionController alloc] init];
    
//    av_register_all();
    
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

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"table", nil) style:UIBarButtonItemStylePlain target:self action:@selector(jump)];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"set", nil) style:UIBarButtonItemStylePlain target:self action:@selector(setting)],[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"file", nil) style:UIBarButtonItemStylePlain target:self action:@selector(fileReviewAction)]];
    
    
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
