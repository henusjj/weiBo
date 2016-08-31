//
//  SyjOAuthModel.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/8/1.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "SyjOAuthModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

#define accountFileName @"account.data"

@implementation SyjOAuthModel
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    SyjOAuthModel *account = [[SyjOAuthModel alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.remind_in = dict[@"remind_in"];
    account.uid = dict[@"uid"];
    return account;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    // 如果想简化写入文件和从该文件中读取的代码, 可以用运行时完成
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.remind_in forKey:@"remind_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
}
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    return self;
}

-(BOOL)save{
    //获取沙河路径
    NSString *accountPath=[accountFileName appendDocumentDir];//这是Nsstring的的扩张方法，，把路径拼接起来
    //生成真正的过期时间
    NSDate *now=[NSDate date];
    self.exprres_time=[now dateByAddingTimeInterval:[self.expires_in doubleValue]];
    
    //将自己存储起来
    return [NSKeyedArchiver archiveRootObject:self toFile:accountPath];
    
    
}

+(instancetype)accontFromSandBox{
    //获取沙河路径
    NSString *accountPath=[accountFileName appendDocumentDir];
    //取出模型对象
    SyjOAuthModel *account=[NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    
    //判断授权是否过期
    NSDate *now=[NSDate date];
    if ([now compare:account.exprres_time]) {
        return nil;
    }
    return account;
}

@end
