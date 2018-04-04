//
//  View2Controller.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/19.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface View2Controller : UIViewController

@end


typedef NS_ENUM(NSInteger,ControllerType){
    ControllerTypeFileRead,//文档阅读
    ControllerTypeDynamic,//物理仿真
    ControllerTypeReactiveCocoa,//响应式
    ControllerTypeWebviewToOc,//自建html和oc交互
};
@interface View2Controller(type)
/**页面类型*/
@property (nonatomic) ControllerType controllerType;
@end
