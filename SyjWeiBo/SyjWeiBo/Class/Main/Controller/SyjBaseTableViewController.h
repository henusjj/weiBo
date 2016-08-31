//
//  SyjBaseTableViewController.h
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/22.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyjDefaultView.h"

@interface SyjBaseTableViewController : UITableViewController
/**
 *  默认视图
 */

@property(nonatomic,weak)SyjDefaultView *defaultCenterView;
//父类中的属性，子类可以用




@end
