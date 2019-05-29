#iOS 相机实时滤镜效果
实现了实时滤镜、拍照、录像功能。

苹果有简单的 UIImagePickerController ，但扩展性差。所以我采用的是 AVFoundation 框架。其涉及到输入流和输出流，方便我们对每一帧进行处理，显示出来。

1输入流要通过相关设备初始化。
    
    // 图像
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _cameraDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];

    // 音频
    AVCaptureDevice *micDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        _microphoneDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:micDevice error:nil];
