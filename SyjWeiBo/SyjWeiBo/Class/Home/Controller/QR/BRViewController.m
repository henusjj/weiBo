//
//  BRViewController.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/9.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "BRViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BRViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
/**
 *  预览界面
 */
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) CADisplayLink *link;

/**
 *  点击我的名片，生成二维码
 */

@property (weak, nonatomic) IBOutlet UIBarButtonItem *Mycard;


@end

@implementation BRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        //没有工具类HM的时候，扫描条形维码，+sb
    //创建定时器
    CADisplayLink *link=[CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    self.link=link;
    
    /*
     什么是输入设备: 摄像头, 话筒
     */
    // 1.获取输入设备
//warning 注意, 获取输入设备一定要通过default方法获取, 不能直接alloc init, 否则报错
    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2.根据输入设备创建输入对象
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:inputDevice error:NULL];
    
    // 3.创建输出对象
    AVCaptureMetadataOutput *output =[[AVCaptureMetadataOutput alloc] init];
    // 4.设置输出对象的代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 5.创建会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    self.session = session;
    // 6.将输入和输出添加到会话中
//warning 由于输入和输入不能重复添加, 所以添加之前需要判断是否可以添加
    if ([session canAddInput:input]) {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output]) {
        [session addOutput:output];
    }
    // 7.设置输出的数据类型(告诉输出对象能够解析什么类型的数据)
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeITF14Code]];
    
    
    // 8.设置预览界面
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    previewLayer.frame = self.view.bounds;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    // 8.开始采集数据
//warning 扫描二维码是一个很持久的操作, 也就是说需要花费很长的时间
    [session startRunning];

    
}


#pragma mark -  AVCaptureMetadataOutputObjectsDelegate
// 只要解析到了数据就会调用
// 注意: 该方法的调用频率非常高
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
//    DDActionLog;
    // 1.判断是否解析到了数据
    if (metadataObjects.count > 0 ) {
        // 2.停止扫描
        [self.session stopRunning];
        
        // 3.移除预览界面
        [self.previewLayer removeFromSuperlayer];
        
        // 4.取出数据
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        DDLogDebug(@"%@", obj.stringValue);
        
        // 5.停止动画
        [self.link invalidate];
        self.link = nil;
        
        // 6.显示数据
        UILabel *labbel = [[UILabel alloc] initWithFrame:self.view.bounds];
        labbel.numberOfLines = 0;
        labbel.text = obj.stringValue;
        [self.view addSubview:labbel];
    }
}

-(void)update{
    DDLogDebug(@"-----");
//        [self.link invalidate];
    
}


#pragma mark -点击tabbarItem事件


#pragma mark -生成二维码

- (IBAction)CreateMyCard:(UIBarButtonItem *)sender {
    
}



@end
