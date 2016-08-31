//
//  SyjSearchBar.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/8/4.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "SyjSearchBar.h"

@implementation SyjSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    //代码创建重写调用
    if (self=[super initWithFrame:frame]) {
        [self setSearch];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    //xib  or SB
    if (self=[super initWithCoder:aDecoder]) {
        [self setSearch];
    }
    return self;
}


#pragma mark -设置searchBar
-(void)setSearch{
    DDLogDebug(@"%s",__func__);
    
    //自定义搜索框
//    UITextField *searchTf=[[UITextField alloc]init];
    //1,设置大小
    self.frame=CGRectMake(0, 0, 300, 30);
    //2.设置边框样式
    self.borderStyle=UITextBorderStyleRoundedRect;//圆角
    //3,设置提醒文本
    self.placeholder=@"请输入您想搜索的类容";
    
    //4,添加放大镜，通过UIImageView的initWithimage方法创建图片容器，不需要设置frame，默认的frame就是image的宽高
    UIImageView *icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_searchlist_search_icon"]];
    
    //5,添加到searchTf
    [self addSubview:icon];
    //6,uitextFile 的leftView属性默认是不会现实的，必须设置leftMode
    self.leftView=icon;//不能缺少，他表示的是在右边的占位
    self.leftViewMode= UITextFieldViewModeAlways;
    
    //设置清除按钮
    self.clearButtonMode=UITextFieldViewModeAlways;//就是那个小叉叉
    
}

@end
