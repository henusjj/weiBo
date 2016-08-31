//
//  SyjDefault.h
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/22.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SyjDefaultView;

/**
 * 为注册，登录按钮 创建协议，因为我们点击注册和登录的时候，要让控制器的CONtroller来执行 ，而不是UIview
 */

@protocol SyjDefaultViewClickDelegate <NSObject>

//协议的方法
-(void)defaultView:(SyjDefaultView *)defaultView didClickLogin:(UIButton *)loginBtn;
-(void)defaultView:(SyjDefaultView *)defaultView didClivkRegister:(UIButton *)registerBtn;


@end


@interface SyjDefaultView : UIView

//外部属性，提供给各个Controller使用
//图片名称
@property(nonatomic,strong)NSString *imgName;

//描述信息
@property(nonatomic,strong)NSString *Deatiltext;

//转盘
@property (weak, nonatomic) IBOutlet UIImageView *BigImageView;



@property(nonatomic,weak)id <SyjDefaultViewClickDelegate> delegate;

//重写
+(instancetype)defaultView;


/**
 *  开始转动
 */
-(void)startRotate;
-(void)stopRotate;

@end
