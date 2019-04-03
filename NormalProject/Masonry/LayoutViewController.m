//
//  LayoutViewController.m
//  NormalProject
//
//  Created by gyh on 2019/3/30.
//  Copyright © 2019 gyh. All rights reserved.
//

#import "LayoutViewController.h"
#import <Masonry/Masonry.h>
#import "UIView+Color.h"

#import <AVKit/AVKit.h>

@interface LayoutViewController ()

@property (nonatomic,weak) UIButton *btn;
@property (nonatomic,strong) AVPlayer *player;

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor brownColor];
    self.btn = btn;
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(60);
        make.right.equalTo(self.view).offset(-60);
        make.height.equalTo(@(30));
    }];
    NSLog(@"1-btn.frame:%@",NSStringFromCGRect(self.btn.frame));
    
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    NSLog(@"111-btn.frame:%@",NSStringFromCGRect(self.btn.frame));
    [self.btn gradientTop:[UIColor redColor] bottom:[UIColor greenColor]];
}

- (void)playVideo{
    NSString *fileUrl = @"";
    self.player = [	AVPlayer playerWithURL:[NSURL URLWithString:fileUrl]];
    
}

//- (void)injected
//{
//    NSLog(@"I've been injected: %@", self);
//    // 自定义修改
//    // .....
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
