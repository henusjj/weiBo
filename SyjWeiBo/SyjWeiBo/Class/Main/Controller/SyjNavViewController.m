//
//  SyjNavViewController.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/26.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "SyjNavViewController.h"

@interface SyjButton : UIButton

@end

@implementation SyjButton

-(void)setHighlighted:(BOOL)highlighted{
    //什么都不用写，继承UIbutton的按钮没有高亮状态
}

@end



@interface SyjNavViewController ()

@end

@implementation SyjNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    设置相关的属性
    //取出导航条item的外观对象
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateNormal];
    
    //设置高亮状态文字的颜色
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
