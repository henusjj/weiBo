//
//  QRViewController.m
//  SyjWeiBo
//
//  Created by 史玉金 on 16/7/9.
//  Copyright © 2016年 史玉金. All rights reserved.
//

#import "QRViewController.h"
//#import "HMPreView.h"


@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate>
//输入设备(用来获取外界信息)
@property(nonatomic,strong)AVCaptureDeviceInput *input;
//输出设备（将收集到的信息，做解析，来获取收到的类容）
@property(nonatomic,strong)AVCaptureMetadataOutput *output;

@property(nonatomic,strong)AVCaptureSession *session;
//4,这里通过自定义类的layer（展示输入设备所采集的信息）

@property(nonatomic,strong)HMPreView *preview;




@end

@implementation QRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreatItem];
    
    [self star];
}

#pragma mark -扫描
-(void)star{
    //1输入设备（用来获取外界信息）
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input=[AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //2输出设备（将收集到的信息，解析，来获取收到的内容）
    self.output=[AVCaptureMetadataOutput new];
    
    //3会话session
    self.session=[AVCaptureSession new];
    //会话扫描展示的大小
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    //会话跟输入和输出设备的关联
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    //制定输出设备的代理，用来接收返回的数据
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置条码类型，二维码QRCode（设置输出的数据类型(告诉输出对象能够解析什么类型的数据)）
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
//     [self.output setMetadataObjectTypes:
//     
//     @[AVMetadataObjectTypeUPCECode,
//     
//     AVMetadataObjectTypeCode39Code,
//     
//     AVMetadataObjectTypeCode39Mod43Code,
//     
//     AVMetadataObjectTypeEAN13Code,
//     
//     AVMetadataObjectTypeEAN8Code,
//     
//     AVMetadataObjectTypeCode93Code,
//     
//     AVMetadataObjectTypeCode128Code,
//     
//     AVMetadataObjectTypePDF417Code,
//     
//     AVMetadataObjectTypeAztecCode,
//     
//     AVMetadataObjectTypeInterleaved2of5Code,
//     
//     AVMetadataObjectTypeITF14Code,
//     
//     AVMetadataObjectTypeDataMatrixCode]];
    
    
    //4layer
    
    
    self.preview=[[HMPreView alloc]initWithFrame:self.view.bounds];
    //                  [view addSubview:self.preview];
    
    
    self.preview.session=self.session;//调用session的set方法
    [self.view addSubview:self.preview];
    
    //5启动会话
    [self.session startRunning];
    

}

#pragma mark -  AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // 1.判断是否解析到了数据
    if (metadataObjects.count > 0 ) {
        // 2.停止扫描
        [self.session stopRunning];
        // 3.移除预览界面
        [self.preview removeFromSuperview];
        // 4.取出数据
        //        DDLogDebug(@"%@", [metadataObjects lastObject]);
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        DDLogDebug(@"%@", obj.stringValue);
        
//        // 5.停止动画
        
        [[HMPreView alloc]stop];
        
        // 6.显示数据
        UILabel *labbel = [[UILabel alloc] initWithFrame:self.view.bounds];
        labbel.numberOfLines = 0;
        labbel.text = obj.stringValue;
        [self.view addSubview:labbel];
    }


        

}


#pragma mark --创建Item
-(void)CreatItem{
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backController)];
    
    self.navigationItem.leftBarButtonItems=@[leftItem];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"相册" style:    UIBarButtonItemStylePlain target:self action:@selector(PhotosClick)];
    
    self.navigationItem.rightBarButtonItems=@[rightItem];

    
}

#pragma mark -返回Home控制器
-(void)backController{
    if (!self.session.isRunning) {
        return;
    }
    self.preview=nil;

    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    [self.navigationController popToViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#>];
}

#pragma mark -打开相册
-(void)PhotosClick{
    
    
}




@end
