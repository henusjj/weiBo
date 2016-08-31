//
//  NetworkTool.h
//  封装的AFN
//
//  Created by 史玉金 on 16/7/22.
//  Copyright © 2016年 史玉金. All rights reserved.
//
#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>
@class NetworkingProxy;

//网络工具协议
@protocol NetworkingProxy <NSObject>

/// 网络请求方法
///
/// @param method     HTTP 请求方法
/// @param URLString  URLString
/// @param parameters 参数字典
/// @param success    成功回调
/// @param failure    失败回调
/// @return NSURLSessionDataTask

//可选择实现
@optional
//从AFN中找到的
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;


/**
 *  出现的问题是协议中的方法没有在AFN中寻找,这是因为我们的工具类没有继承AFHTTPSessionManager，so，不能调用父类的这个方法
 */
@end








/**
 *  创建单例类
 */
//网络请求枚举

typedef enum:NSUInteger{
    GET,
    POST,
} RequestMethod;

@interface NetworkTool : AFHTTPSessionManager<NetworkingProxy>

//自定义一个类,创建单例对象
+(instancetype)sharedTool;

//定义一个方法，获取网络请求
-(void)request:(RequestMethod)method URLstring:(NSString *)urlString parameters:(id)parameters finished:(void (^)(id result,NSError *error))finished;

-(void)loadAcessToken:(NSString *)code finishe:(void (^)(id, NSError *))finished;

@end
