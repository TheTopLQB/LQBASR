//
//  LQBXFViewController.m
//  LQBASR
//
//  Created by 李庆彬 on 26/02/2018.
//  Copyright © 2018 LQB. All rights reserved.
//

#import "LQBXFViewController.h"
#import "IFlyMSC/IFlyMSC.h"

@interface LQBXFViewController ()<IFlySpeechRecognizerDelegate>
@property (strong, nonatomic) IFlySpeechRecognizer * iFlySpeechRecognizer;
@property (strong, nonatomic) UITextView * inPutTextView;

@end

@implementation LQBXFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建语音识别对象
    _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    //设置识别参数
    //设置为听写模式
    [_iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
    [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    _iFlySpeechRecognizer.delegate = self;
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 80, 200, 30);
    [btn setTitle:@"录音" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(speech:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextView * inPutTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 150, 200, 200)];
    self.inPutTextView = inPutTextView;
    [self.view addSubview:inPutTextView];
}

- (void)speech:(UIButton*)btn {
    //启动识别服务
    [_iFlySpeechRecognizer startListening];
}

//IFlySpeechRecognizerDelegate协议实现
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSDictionary * resultDic = results.firstObject;
    NSString * jsonString = resultDic.allKeys.firstObject;
    if (jsonString == nil) {
        return;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return;
    }
    NSLog(@"-----%@",dic);
    if (self.inPutTextView.text.length) {
        return;
    }
    self.inPutTextView.text = [self.inPutTextView.text stringByAppendingString:jsonString];;
}
//识别会话结束返回代理
- (void)onError: (IFlySpeechError *) error{
    
}
//停止录音回调
- (void) onEndOfSpeech{
    
}
//开始录音回调
- (void) onBeginOfSpeech{
    
}
//音量回调函数
- (void) onVolumeChanged: (int)volume{
    
}
//会话取消回调
- (void) onCancel{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
