//
//  BaseViewController.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/7.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define AppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@class CEReversibleAnimationController, CEBaseInteractionController;

@interface BaseViewController : UIViewController

@property (strong, nonatomic) CEReversibleAnimationController *settingsAnimationController;
@property (strong, nonatomic) CEReversibleAnimationController *navigationControllerAnimationController;
@property (strong, nonatomic) CEBaseInteractionController *navigationControllerInteractionController;
@property (strong, nonatomic) CEBaseInteractionController *settingsInteractionController;
@end
