//
//  LayoutViewController.m
//  NormalProject
//
//  Created by gyh on 2019/3/30.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "LayoutViewController.h"

@interface LayoutViewController ()

@property (nonatomic,weak) UIButton *btn;

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] init];
    self.btn = btn;
    [self.view addSubview:btn];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
