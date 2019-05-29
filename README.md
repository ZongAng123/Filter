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

2. 初始化输出流
    _queue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);

    // 图像
    _videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    _videoDataOutput.videoSettings = @{(id)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInteger:kCVPixelFormatType_32BGRA]};
    _videoDataOutput.alwaysDiscardsLateVideoFrames = YES;
    [_videoDataOutput setSampleBufferDelegate:self queue:_queue];
    
    // 音频
    _audioDataOutput = [[AVCaptureAudioDataOutput alloc] init];
        [_audioDataOutput setSampleBufferDelegate:self queue:_queue];

创建了一个串行队列，以确保每一帧按顺序处理。输出流的回调方法为- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection;。
