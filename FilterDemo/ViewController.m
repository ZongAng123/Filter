//
//  ViewController.m
//  FilterDemo
//  iOS 相机实时滤镜效果
//  Created by 纵昂 on 2019/5/28.
//  Copyright © 2019 GitHub:https://github.com/ZongAng123. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong) UIButton * photo_btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    实现了实时滤镜、拍照、录像功能
    _photo_btn =[[UIButton alloc]initWithFrame:CGRectMake(50, 100, 60, 60)];
    [_photo_btn setTitle:@"相机" forState:UIControlStateNormal];
    [_photo_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_photo_btn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_photo_btn];
    
}
/** 原理:
    设备获取图像输入流后，经过对该帧处理形成新图像，最后刷新UI。
 **/
-(void)cameraBtnClick:(UIButton *)sendeer{
    NSLog(@"123");
    if ([self isCameraAvailable]) { // 有摄像头
        NSString *mediaType = AVMediaTypeVideo;// 读取媒体类型
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];// 读取设备授权状态
        
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            NSString *errorStr = @"应用相机权限受限,请在设置中启用";
            [self showAlertControllerWithMessage:errorStr];
            return;
        } else if (authStatus == AVAuthorizationStatusAuthorized) { // 有权限
            [self presentToCameraVC];
        } else if (authStatus == AVAuthorizationStatusNotDetermined) { // 获取权限
            [self alertPromptToAllowCameraAccessViaSetting];
        }
    } else { // 无摄像头
        [self showAlertControllerWithMessage:@"该设备无摄像头"];
    }
}

/**
 请求权限
 */
- (void)alertPromptToAllowCameraAccessViaSetting {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                [self presentToCameraVC];
            } else {
                [self showAlertControllerWithMessage:@"未获得权限"];
            }
        });
    }];
}

- (void)presentToCameraVC {
    CustomCameraViewController *vc = [[CustomCameraViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)showAlertControllerWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 设备是否有摄像头
 
 @return 设备是否有摄像头
 */
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


@end
