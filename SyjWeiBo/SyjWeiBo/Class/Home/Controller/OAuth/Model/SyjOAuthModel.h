//
//  SyjOAuthModel.h
//  SyjWeiBo
//
//  Created by 史玉金 on 16/8/1.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *   "access_token" = "2.009fCrQEqqwcCEf7b6c1ec7dVNrauB";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3913594346;
 */


@interface SyjOAuthModel : NSObject<NSCoding>
/**
 *  访问令牌
 */
@property(nonatomic,copy)NSString *access_token;

/**
 *  多少秒之后过期
 */
@property(nonatomic,strong)NSNumber *expires_in;

/**
 *  多少秒之后提示过期
 */
@property(nonatomic,strong)NSNumber *remind_in;
/**
 *  真正的过期时间
 */
@property(nonatomic,strong)NSDate *exprres_time;

/**
 *  用户Id
 */
@property(nonatomic,strong)NSNumber *uid;

/**
 *  保存授权模型到三个本地存储中，也就是我们的文件，缓存，以及零时文件
 *
 *  @return yes
 */
-(BOOL)save;

/**
 *  从沙河中获取授权模型
 */

+(instancetype)accontFromSandBox;


//字典啊转模型
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
