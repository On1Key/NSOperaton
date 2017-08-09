//
//  CellModel.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/6/29.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "CellModel.h"
#import "NSObject+url.h"

@implementation CellModel
- (void)setUrl:(NSString *)url{
    _url = url;
    
//    CGSize imagesize = [NSObject getImageNewSizeWithURL:url];
//    CGSize lastSize = CGSizeZero;
//    if (imagesize.width >= imagesize.height) {
//        if (imagesize.width >= 200) {
//            lastSize.width = 120;
//            lastSize.height = imagesize.height / imagesize.width * lastSize.width;
//        }
//    }else{
//        if (imagesize.height >= 200) {
//            lastSize.height = 120;
//            lastSize.width = imagesize.width / imagesize.height * lastSize.height;
//        }
//    }
//    
//    _imageSize = lastSize;
}
+ (NSArray *)allModels{
    
    NSArray *images = @[@"https://youhaodongxi.b0.upaiyun.com/assets/mobile/app/img/msg_ic_yhdx.png",
                     @"https://youhaodongxi.b0.upaiyun.com/assets/mobile/app/img/msg_ic_fbh.png",
                     @"http://youhaodongxi.b0.upaiyun.com//upload/test1465383761.jpg",
                     @"http://youhaodongxi.b0.upaiyun.com//upload/test1469695634.jpg",
                     @"http://wx.qlogo.cn/mmopen/Rf6wm2QAckqLu7S5r2icdRjLNjYxBDvGI0tXd6je8X6hGneoribwGcjH3x4658uPSc7TvHNcxhLARbPcqgiaoRNEA/0",
                     @"http://wx.qlogo.cn/mmopen/Rf6wm2QAckpksgFzDkxia7Tp7nxyicXibYCDATUHbVqrAJN0Mx23UJkJLiaicydQ7rzFAHlZzVzooGziarichXJkA3tSoJbQ2lxAy8Q/0",
                     @"http://youhaodongxi.b0.upaiyun.com//upload/test1466412459.jpg",
                     @"https://imgcdn.youhaodongxi.com/201704/9152322.jpg",
                     @"https://youhaodongxi.b0.upaiyun.com/201703/25/3453537.jpg",
                     @"https://imgcdn.youhaodongxi.com/201704/4080346.jpg",
                     @"https://youhaodongxi.b0.upaiyun.com/story/images/201706/A73AB96A-BAE3-4DAF-A491-D9039B8BAB82.jpg",
                     @"https://youhaodongxi.b0.upaiyun.com/story/images/201706/7F2C45C6-CD08-4394-93EA-929EB5E12FC7.jpg",
                     @"https://youhaodongxi.b0.upaiyun.com/story/images/201706/1496644562898e613d3d6ba6c1524b4abab146249dac0.jpg"];
    
    NSMutableArray *models = [NSMutableArray array];
    for (int i =0;i < images.count;i ++) {
        CellModel *model = [CellModel new];
        model.str = [@"row:" stringByAppendingString:[@(i) stringValue]];
        model.url = images[i];
        [models addObject:model];
    }
    
    return models;
    
}
@end
