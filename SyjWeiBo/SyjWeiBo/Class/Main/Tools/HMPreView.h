//
//  HMPreView.h
//  二维码扫描
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface HMPreView : UIView

@property (nonatomic,strong)AVCaptureSession *session;
//
//@property (nonatomic,strong)NSTimer *timer;
-(void)stop;
@end
