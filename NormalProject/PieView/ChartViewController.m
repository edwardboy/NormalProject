//
//  ChartViewController.m
//  NormalProject
//
//  Created by gyh on 2019/4/9.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "ChartViewController.h"
#import "JHRingChart.h"
#import "UIImage+Category.h"

@interface ChartViewController ()

@property (nonatomic,weak) JHRingChart *ring;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self setupView];
    
//    [self testNullSafe];

    [self testArray];
}

- (void)testArray{
    
    NSArray *contents = @[@"123",@"345",@"567"];
    NSArray *content1 = @[@"123"];
    NSArray *content2 = @[];
    
    NSString *obj = [contents objectAtIndex:3];

    NSLog(@"obj：%@，contents:%@,content1:%@,content2:%@",obj,contents,content1,content2);
}

- (void)testNullSafe{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNull null] forKey:@"123"];
    NSLog(@"dic:%@",dic);

    
    NSString *imgPath = @"https://resource.amez999.com/goods/profile/shop/257/2019/01/15/NnJZNzYBNe.png";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgPath]];
        UIImage *img = [UIImage imageWithData:imgData];
        NSLog(@"Memory Size:%@",[img memoryBitSize]); // 输出 2910720
    });
    
}

- (void)setupView{
    
    JHRingChart *ring = [[JHRingChart alloc] initWithFrame:CGRectMake(0, 88, k_MainBoundsWidth, 231)];
    /*        background color         */
    ring.backgroundColor = [UIColor whiteColor];
    /*        Data source array, only the incoming value, the corresponding ratio will be automatically calculated         */
    ring.valueDataArr = @[@"0.3",@"0.25",@"0.2",@"0.15",@"0.08",@"0.02"];
    /*         Width of ring graph        */
    ring.ringWidth = 35.0;
    /*        Fill color for each section of the ring diagram         */
    ring.fillColorArray = @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000]];
    ring.items = @[@"彩妆香水",@"专业美容",@"服装配饰",@"食品健康",@"生活家居",@"母婴用品"];
    /*        Start animation             */
    [ring showAnimation];
    ring.title = @"类目表";
    self.ring = ring;
    [self.view addSubview:ring];
}

@end
