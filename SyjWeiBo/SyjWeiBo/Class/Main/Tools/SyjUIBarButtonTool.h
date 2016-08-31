//
//  SyjUIBarButtonTool.h
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/17.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyjUIBarButtonTool : NSObject

//创建一个方法
-(UIBarButtonItem *)itemWithImage:(NSString *)imgName andHigImg:(NSString *)higImgName andTager:(id)tager addAction:(SEL)action;

@end
