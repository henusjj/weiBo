//
//  OAuthViewController.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/26.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "OAuthViewController.h"
#import "SVProgressHUD.h"
#import "NetworkTool.h"
#import "SyjOAuthModel.h"

//获取授权RequestToken
/*
https://api.weibo.com/oauth2/authorize
HTTP请求方式
GET/POST
请求参数
必选	类型及范围	说明
client_id	true	string	申请应用时分配的AppKey。
redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。

*/


//获取令牌需要的参数
/**
 https://api.weibo.com/oauth2/access_token
 HTTP请求方式为 POST
 
 *  client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */

@interface OAuthViewController ()<UIWebViewDelegate>



@end

@implementation OAuthViewController
-(void)loadView{
    //model一个webView界面
    self.view=[[UIWebView alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化导航控制器
    self.navigationItem.rightBarButtonItems=@[[[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(close)]];
    
    //加载登录界面
    [self loadOAuth];
    
}
#pragma mark ---加载Oauth

//定义宏
#define OAuthURL @"https://api.weibo.com/oauth2/access_token"
//参数
//#define OAuthAppkey @"3703366692"
//#define OAuthAppSecret @"f56b6cdbba4a413b1c2ed215d5ad18de"
//#define OAuthTypr @"authorization_code"
//#define OAuthCode @"01a14b105e198e27026bfc71c64841e7"
//#define OAuthuri @"http://www.baidu.com"
//利用AFN发送post请求，方法中，有一个字典参数，


-(void)loadOAuth{
//    通过post请求，获取令牌
    //拼接字符串，获取授权登录界面
    NSString *urlString=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=3703366692&redirect_uri=http://www.baidu.com"];
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    UIWebView *webLoginView=(UIWebView *)self.view;//是一个UIViewController，我们把他的view变成webview
    //设置代理
    webLoginView.delegate=self;
    [webLoginView loadRequest:request];
    
}

#pragma mark --返回上一个界面
-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --webView的代理方法
//只要webView发送求就会调用，request，是webView是即将要请求的地址，返回yes代表允许继续加载，否则就是不允许加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //在这里我们将判断request，也就是我们即将要访问的地址，来获取我们授权的RequestToken的ASccess_Token 也就是我们的令牌
    
    // 1.判断即将要请求的url中是否包含code=, 如果包含证明已经拿到了已经授权的RequestToken, 不需要继续请求下一个网页了
    NSString *urlRequest=request.URL.absoluteString;//请求的绝对地址
    NSRange range=[urlRequest rangeOfString:@"code="];
    //    range.location; 如果字符串中不包含查找的字符串返回NSNotFound, 如果包含返回查询字符串的第一个字符在字符串中出现的位置
    //    range.length; 如果字符串中不包含查找的字符串返回0, 否则返回查询字符串的长度

    if (range.location!=NSNotFound) {
        DDLogDebug(@"获取已经授权的RequesToken：%@",urlRequest);
        
        //2截取字符串已经授权的REquestToken
        NSUInteger starIndex=range.location+range.length;
        NSString *code=[urlRequest substringFromIndex:starIndex];
        DDLogDebug(@"code=%@",code);
        
        //code就是我们获取已经授权的RequestToken
        //根据已经授权的RequestToken获取令牌accessToken
        [self accessTokenWith:code];
        return NO;
    }
    
    
    return YES;
    
}
//利用网络工具类
-(void)accessTokenWith:(NSString *)code{
//    id re;
    //利用AFN网络请求
    [[NetworkTool sharedTool] loadAcessToken:code finishe:^(id result, NSError *error) {
    //这里输出的结果我们网络工具类中中返回调用的
        if (error!=nil) {
            NSLog(@"出错了%@",error);
            return ;
        }
        else{
        NSLog(@"--result%@",result);//我们需要的字典模型，也就是令牌accessToken
#pragma mark --将获取的字典转换成模型
            SyjOAuthModel *account=[SyjOAuthModel accountWithDict:result];
//            SyjOAuthModel *account=[SyjOAuthModel mj_objectWithKeyValues:result context:nil];//利用你mJ第三方库，字典转模型
            //把模型保存到沙河中。
            [account save];
        }
    }];

    

}


/**
 SVProgressHUD
 *  下面的代理方法，我们运用第三方库来展示不同阶段呈现给用户的界面
 */

//开始加载网页是调用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //提示用户正在加载
    [SVProgressHUD showWithStatus:@"正在加载ing"];
    
}
//加载完毕时调用
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //隐藏提示
    [SVProgressHUD dismiss];
}

//加载错误是调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    //隐藏提示
//    DDLogDebug(@"-----zhei %s---%@",__func__,error);
    
    [SVProgressHUD dismiss];
}


@end
