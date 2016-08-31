//
//  NetworkTool.m
//  封装的AFN
//
//  Created by 史玉金 on 16/7/22.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "NetworkTool.h"

//遵循这个协议，实现协议的方法，当调用协议的时候，进入到AFN中

@interface NetworkTool()

@end


@implementation NetworkTool

//创建单例
+(instancetype)sharedTool{
    static NetworkTool *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       //这个单例包含我们公司的url
        //测试用的http://httpbin.org/
        
//        NSURL *baseUrl=[NSURL URLWithString:@"http://httpbin.org/"];
        tools=[[self alloc]initWithBaseURL:nil];
        
        //设置反序列化格式
        tools.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
//        tools.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/plain"];

        
    });
    return tools;
}


#pragma mark 封装AFN的网络方法


-(void)request:(RequestMethod)method URLstring:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id, NSError *))finished{
    
    NSString *methodName=(method==GET) ? @"GET" : @"POST";
    // dataTaskWithHTTPMethod本类没有实现方法，但是父类实现了
    // 在调用方法的时候，如果本类没有提供，直接调用父类的方法，AFN 内部已经实现！
    /**
     *  定义一个协议，让NETworking遵循这个协议，执行需要的方法
     */
    
    
 [[self dataTaskWithHTTPMethod:methodName URLString:urlString parameters:parameters uploadProgress:nil downloadProgress:^(NSProgress *downloadProgress) {
     NSLog(@"%@",downloadProgress);
 } success:^(NSURLSessionDataTask *task, id responseObject) {
     finished(responseObject,nil);
//        DDLogDebug(@"换取AccessToken成功 = %@", responseObject);

 } failure:^(NSURLSessionDataTask *task, NSError * error) {
//     NSLog(@"%@",error);
        finished(nil,error);
 }] resume];
    

}



#pragma mark ---OAuth的相关方法
#define OAuthAppkey @"3703366692"
#define OAuthAppSecret @"f56b6cdbba4a413b1c2ed215d5ad18de"
#define OAuthTypr @"authorization_code"
//#define OAuthCode @"01a14b105e198e27026bfc71c64841e7"每次都会变化
#define OAuthuri @"http://www.baidu.com"

-(void)loadAcessToken:(NSString *)code finishe:(void (^)(id, NSError *))finished{
    
    NSString *urkString=@"https://api.weibo.com/oauth2/access_token";
    NSDictionary *params=@{@"client_id": OAuthAppkey,
                           @"client_secret": OAuthAppSecret,
                           @"grant_type": OAuthTypr,
                           @"code": code,
                          @"redirect_uri": OAuthuri
                           };
    
    [self request:POST URLstring:urkString parameters:params finished:finished];
}


//
//"access_token" = "2.009fCrQEqqwcCEf7b6c1ec7dVNrauB";
//"expires_in" = 157679999;
//"remind_in" = 157679999;
//uid = 3913594346;





@end
