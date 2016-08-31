//
//  SyjUIBarButtonTool.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/17.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "SyjUIBarButtonTool.h"

@implementation SyjUIBarButtonTool

-(UIBarButtonItem *)itemWithImage:(NSString *)imgName andHigImg:(NSString *)higImgName andTager:(id)tager addAction:(SEL)action{
//    //设置图片
//    UIImage *img=[UIImage imageNamed:@"navigationbar_friendsearch"];
    UIButton *LeftBt=[[UIButton alloc]init];
    //设置对应状态的图片
    [LeftBt setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [LeftBt setImage:[UIImage imageNamed:higImgName] forState:UIControlStateHighlighted];
    //设置点击事件
    [LeftBt addTarget:tager action:action forControlEvents:UIControlEventTouchUpInside];
    
    LeftBt.size=LeftBt.currentImage.size;
//    DDLogDebug(@"%@",LeftBt.frame);
    
    return [[UIBarButtonItem alloc]initWithCustomView:LeftBt];

}

@end
