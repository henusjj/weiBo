//
//  SyjBaseTableViewController.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/22.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "SyjBaseTableViewController.h"

//#import "SyjDefaultView.h"
//#import "SyjNavViewController.h"
//#import "OAuthViewController.h"
//遵循协议
@interface SyjBaseTableViewController ()<SyjDefaultViewClickDelegate>

@end

@implementation SyjBaseTableViewController


//loadView方法是用来负责创建UIViewController的view
-(void)loadView{
    //取出模型对象
    SyjOAuthModel *account=[SyjOAuthModel accontFromSandBox];
    //从沙河中获取，如何获取，我们需要设置方法
    
    //判断是否授权
    if (account!=nil) {
        //已经授权
        [super loadView];
    }
    //从沙河中获取access-token，如果得到数据，就表明我们一登录授权，直接出现首页，tableView
    
    else{
    //如果没有的话，我们就加载下面的我们自定义的View，出现在每个界面，然后获取access-Token
    
    SyjDefaultView *defaultView=[SyjDefaultView defaultView];
    self.view=defaultView;
    self.defaultCenterView=defaultView;
    
    //设置代理
    self.defaultCenterView.delegate=self;
    }
}

#pragma mark -实现代理方法
//登录按钮
-(void)defaultView:(SyjDefaultView *)defaultView didClickLogin:(UIButton *)loginBtn{
    DDLogDebug(@"login");
    
    //点击登录按钮，我们model的一个控制器，带有UINavcontroller
    SyjNavViewController *nv=[[SyjNavViewController alloc]init];
    //创建授权登录控制器
    OAuthViewController *vc=[[OAuthViewController alloc]init];
    [nv addChildViewController:vc];
    
    //弹出授权控制器
    [self presentViewController:nv animated:YES completion:nil];
    
    
}

//注册按钮
-(void)defaultView:(SyjDefaultView *)defaultView didClivkRegister:(UIButton *)registerBtn{
 
    DDLogDebug(@"register");
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//warning Incomplete implementation, return the number of rows
    return 0;
}



@end
