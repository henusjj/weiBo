//
//  SyjDefault.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/22.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "SyjDefaultView.h"

@interface SyjDefaultView ()

//图片名称
@property (weak, nonatomic) IBOutlet UIImageView *iconName;
//详情
@property (weak, nonatomic) IBOutlet UILabel *detailText;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
//注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registerBt;


/**
 *  定时器，用来旋转图片的
 */
@property(nonatomic,strong)CADisplayLink *link;

@end

@implementation SyjDefaultView

////懒加载定时器
//-(CADisplayLink *)link{
//    if (_link==nil) {
//        _link=[CADisplayLink displayLinkWithTarget:self selector:@selector(updata)];
//    }
//    return _link;
//}



//一个外部方法，当我们BaseController需要的时候，调用此方法，直接从Xib中获取此View
+(instancetype)defaultView{
    return [[[NSBundle mainBundle]loadNibNamed:@"SyjDefaultView" owner:nil options:nil]lastObject];
}

//点击登录
- (IBAction)loginClick:(UIButton *)sender {
    //判断是否有代理方法，如果有，让代理对象调用
    if ([self.delegate respondsToSelector:@selector(defaultView:didClickLogin:)]) {
        [self.delegate defaultView:self didClickLogin:sender];
    }
}


//点击注册
- (IBAction)registerClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(defaultView: didClivkRegister:)]) {
        [self.delegate defaultView:self didClivkRegister:sender];
    }
}


-(void)setImgName:(NSString *)imgName{
    _imgName=imgName;
    self.iconName.image=[UIImage imageNamed:imgName];
    
}

-(void)setDeatiltext:(NSString *)Deatiltext{
    _Deatiltext=Deatiltext;
    self.detailText.text=Deatiltext;
}

/**
 *  开始转动
 */

-(void)startRotate{
    //创建定时器
    self.link=[CADisplayLink displayLinkWithTarget:self selector:@selector(updata)];
    
    //将定时器加入到消息循环中
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

-(void)stopRotate{
    
    //销毁定时器
    [self.link invalidate];
    self.link=nil;
}

//旋转
-(void)updata{
    self.BigImageView.transform=CGAffineTransformRotate(self.BigImageView.transform, M_PI / 100);
    
}


@end
