//
//  DiscoverController.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/9.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "DiscoverController.h"
#import "SyjSearchBar.h"
@interface DiscoverController ()<UITextFieldDelegate>

/**
 *  搜索
 
 UITextField
 1.不可以滚动
 2.不可以换行
 3.可以显示提醒文本
 
 UITextView
 1.可以滚动
 2.可以换行
 3.不可以显示提醒文本
 
 
 */
//@property(nonatomic,weak)UITextField *searchTf;


@property(nonatomic,strong)SyjSearchBar *searchTf;

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //设置左边的导航栏文字
//    self.navigationItem.title=@"发现";
    
    
    /*添加搜索框,不符合要求，so，下面我们自定义搜索框
    UISearchBar *searchBar=[[UISearchBar alloc]init];
    self.navigationItem.titleView=searchBar;
    
    */
    
    /*
    //自定义搜索框
    UITextField *searchTf=[[UITextField alloc]init];
    //1,设置大小
    searchTf.frame=CGRectMake(0, 0, 300, 30);
    //2.设置边框样式
    searchTf.borderStyle=UITextBorderStyleRoundedRect;//圆角
    //3,设置提醒文本
    searchTf.placeholder=@"请输入您想搜索的类容";
    
    //4,添加放大镜，通过UIImageView的initWithimage方法创建图片容器，不需要设置frame，默认的frame就是image的宽高
    UIImageView *icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_searchlist_search_icon"]];
    
    //5,添加到searchTf
    [searchTf addSubview:icon];
    //6,uitextFile 的leftView属性默认是不会现实的，必须设置leftMode
    searchTf.leftView=icon;//不能缺少，他表示的是在右边的占位
    searchTf.leftViewMode= UITextFieldViewModeAlways;
    
    //设置清除按钮
    searchTf.clearButtonMode=UITextFieldViewModeAlways;//就是那个小叉叉
    
    //设置代理----text的代理方法
    searchTf.delegate=self;
    
    self.navigationItem.titleView=searchTf;
    
    self.searchTf=searchTf;
     
     */
    
    SyjSearchBar *search=[[SyjSearchBar alloc]init];//init方法
    self.searchTf=search;
    self.searchTf.delegate=self;
    self.navigationItem.titleView=search;
    
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

#pragma mark--textfile的代理方法
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    DDLogDebug(@"%s",__func__);
    //1,在编辑的时候，添加按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    //2.替换leftView，此处不做处理
    
    
    
    
}
-(void)cancle{
    //关闭键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    //移除取消按钮
    self.navigationItem.rightBarButtonItem=nil;
}


#pragma mark -监听ScrollView的拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //1关闭键盘
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //移除取消按钮
    self.navigationItem.rightBarButtonItem=nil;
    
}

@end
