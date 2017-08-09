//
//  TableViewCell.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/6/29.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iocnIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**<#statements#>*/
@property (nonatomic, strong) CellModel * cellModel;
@end
