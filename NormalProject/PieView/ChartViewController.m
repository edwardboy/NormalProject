//
//  ChartViewController.m
//  NormalProject
//
//  Created by gyh on 2019/4/9.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "ChartViewController.h"
#import "JHRingChart.h"

@interface ChartViewController ()

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
}

- (void)setupView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0, 100, k_MainBoundsWidth, k_MainBoundsWidth)];
    /*        background color         */
    ring.backgroundColor = [UIColor whiteColor];
    /*        Data source array, only the incoming value, the corresponding ratio will be automatically calculated         */
    ring.valueDataArr = @[@"0.3",@"0.25",@"0.2",@"0.15",@"0.08",@"0.02"];
    /*         Width of ring graph        */
    ring.ringWidth = 35.0;
    /*        Fill color for each section of the ring diagram         */
    ring.fillColorArray = @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000]];
    /*        Start animation             */
    [ring showAnimation];
    [self.view addSubview:ring];
    ring.title = @"类目表";
}

@end
