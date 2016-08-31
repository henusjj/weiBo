//
//  HomeController.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/9.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "HomeController.h"
#import "QRtabBarController.h"
#import "SyjUIBarButtonTool.h"
#import "SyjDefaultView.h"
#import "SyjOAuthModel.h"
#import "NetworkTool.h"

@interface HomeController ()
@property(nonatomic,weak) SyjDefaultView *defaultView;

/**
 *  微博数组(里面存储的是所有微博的字典)
 */
@property (nonatomic, strong) NSMutableArray *statuses;
@end

@implementation HomeController

#pragma mark -懒加载数组
-(NSMutableArray *)statuses{
    if (_statuses==nil) {
        _statuses=[NSMutableArray arrayWithCapacity:20];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"首页";
    
    //修改登录界面的图片以及文字
    self.defaultCenterView.imgName=@"visitordiscover_feed_image_house";
    self.defaultCenterView.Deatiltext=@"当你关注一些人以后，他们发布的最新消息会显示在这里";
    
    
    //设置左边导航栏
    [self setLeftNavbar];
    
    //设置右边的导航栏
    [self setRightNavbar];
    
//    NSLog(@"%@",NSHomeDirectory());
    
    
#pragma mark -获取用户信息和微博数据
//    [self setupUserInfo];
//    [self loadNewStatuses];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.defaultView startRotate];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.defaultView stopRotate];
}
#pragma mark -设置左边的导航栏
-(void)setLeftNavbar{
//    //设置图片
//    UIImage *img=[UIImage imageNamed:@"navigationbar_friendsearch"];
//    UIButton *LeftBt=[[UIButton alloc]init];
//    //设置对应状态的图片
//    [LeftBt setImage:img forState:UIControlStateNormal];
//    [LeftBt setImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] forState:UIControlStateHighlighted];
//    //设置点击事件
//    [LeftBt addTarget:self action:@selector(meClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *LeftItem=[[UIBarButtonItem alloc]initWithCustomView:LeftBt];
//    //设置大小
//    LeftBt.size=LeftBt.currentImage.size;
//    
//    self.navigationItem.leftBarButtonItems=@[LeftItem];
    
   
    //优化代码，运用工具类
    self.navigationItem.leftBarButtonItem=[[SyjUIBarButtonTool alloc]itemWithImage:@"navigationbar_friendsearch" andHigImg:@"navigationbar_friendsearch_highlighted" andTager:self addAction:@selector(meClick:)];
    
    
}
#pragma mark -左边导航栏的点击事件
-(void)meClick:(UIButton *)sender{
    DDLogDebug(@"me");
}

#pragma mark -设置右边的导航栏
-(void)setRightNavbar{    
    self.navigationItem.rightBarButtonItem=[[SyjUIBarButtonTool alloc]itemWithImage:@"navigationbar_pop" andHigImg:@"navigationbar_pop_highlighted" andTager:self addAction:@selector(QRClick:)];
    
}
#pragma mark -右边导航栏的点击事件
-(void)QRClick:(UIButton *)sender{
    DDLogDebug(@"QR");
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"QR" bundle:nil];//通过sb来找到控制器
    
    QRtabBarController *tabbar=[sb instantiateInitialViewController];
    
    [self presentViewController:tabbar animated:YES completion:nil];//控制器从下往上推出，动画的默认模式
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //创建cell
    static NSString *id=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id];
    }
    //设置数据
    //2.1取出对应行的微博字典
    NSDictionary *status=self.statuses[indexPath.row];
    //2.2从对应行的微博字典中取出对用的用户
    NSDictionary *user=status[@"user"];
    //2.3设置昵称
    cell.textLabel.text=user[@"name"];
    //2.4设置微博
    cell.detailTextLabel.text=status[@"text"];
    //2.5设置用户的图像，这里需要占位符
//    NSURL *iconUrlString = [NSURL URLWithString:user[@"profile_image_url"]];
//#warning 注意:如果使用sd_setImageWithURL下载图片, 一定要指定占位图片, 因为如果不指定占位图片,那么图片默认就没有frame
//    
//    [cell.imageView sd_setImageWithURL:iconUrlString placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];

    
    
    return cell;
}



#pragma mark-获取用户信息,这里自个人的信息，这里我们暂不设置
-(void)setupUserInfo{
    
    //获取请求参数
    //取出授权的模型
    SyjOAuthModel *account=[SyjOAuthModel accontFromSandBox];//这是模型对象
    
    NSDictionary *parameters=@{@"access_token":account.access_token,};
    
    
    
    
}

#pragma mark -懒加载微博数据--上面设置属性数组
-(void)loadNewStatuses{
    //取出授权的模型
    SyjOAuthModel *account=[SyjOAuthModel accontFromSandBox];//这是模型对象
    NSDictionary *parameters=@{@"access_token":account.access_token,};

    //发送请求
    [[NetworkTool sharedTool] request:GET URLstring:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters finished:^(id result, NSError *error) {
        if (error!=nil) {
            NSLog(@"错误----%@",error);
            return ;
        }
         //不出错，保存获取的Json数据
        NSArray *newStatus=result[@"statuses"];
        [self.statuses addObjectsFromArray:newStatus];
        
        //刷新表格
        [self.tableView reloadData];
    }];
}


@end
