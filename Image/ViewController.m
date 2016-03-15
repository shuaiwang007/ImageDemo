//
//  ViewController.m
//  Image
//
//  Created by 王帅 on 16/3/15.
//  Copyright © 2016年 Mr.wang. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+WS.h"

@interface ViewController ()
@property(nonatomic, strong) UIImageView *waterImageView;   // 水印
@property(nonatomic, strong) UIImageView *circleImageView;  // 裁剪
@property(nonatomic, strong) UIButton  *captureImageBtn; // 截图


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildUI];
    [self waterImage];
    [self circleImage];
    
}

- (void)buildUI {
    [self.view addSubview:self.waterImageView];
    [self.view addSubview:self.circleImageView];
    [self.view addSubview:self.captureImageBtn];
}

- (void)waterImage{
    
    // 返回水印图片
    UIImage *newImage = [UIImage waterImageWithBg:@"bg" logo:@"logo"];
    // 显示图片
    self.waterImageView.image = newImage;
    // 将image对象压缩为PNG格式的二进制数据
    NSData *data = UIImagePNGRepresentation(newImage);
    // 写入文件
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"new.png"];
    [data writeToFile:path atomically:YES];
    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
}

- (void)circleImage {
    
    UIImage *newImage = [UIImage circleImageWithName:@"bg" borderWidth:3 borderColor:[UIColor whiteColor]];
    self.circleImageView.image = newImage;
    [self.circleImageView sizeToFit];
    NSData *data = UIImagePNGRepresentation(newImage);
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"new2.png"];
    [data writeToFile:path atomically:YES];
    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
}

- (void)captureImageBtnClick {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 捕捉
        UIImage *newImage = [UIImage captureWithView:self.view];
        // 写文件
        NSData *data = UIImagePNGRepresentation(newImage);
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  lastObject] stringByAppendingPathComponent:@"new3.png"];
        [data writeToFile:path atomically:YES];
        NSLog(path);
        // 也可保存到相册
        UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    });
}


#pragma mark ---- 懒加载
- (UIImageView *)waterImageView {
    if (!_waterImageView) {
        _waterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    }
    return _waterImageView;
}
- (UIImageView *)circleImageView {
    if (!_circleImageView) {
        _circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.waterImageView.frame.size.height + 20, self.view.bounds.size.width - 80, 200)];
    }
    return _circleImageView;
}
- (UIButton *)captureImageBtn {
    if (!_captureImageBtn) {
        _captureImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.circleImageView.frame.size.height + 80, self.view.bounds.size.width, 80)];
        [_captureImageBtn setTitle:@"点我截图" forState:UIControlStateNormal];
        _captureImageBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_captureImageBtn addTarget:self action:@selector(captureImageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _captureImageBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
