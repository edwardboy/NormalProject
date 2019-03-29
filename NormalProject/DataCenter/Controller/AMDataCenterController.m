//
//  AMDataCenterController.m
//  NormalProject
//
//  Created bygyh on 2019/3/25.
//  Copyright © 2019gyh. All rights reserved.
//

#import "AMDataCenterController.h"
#import "AMDataCenterViewModel.h"

@interface AMDataCenterController ()

@property (nonatomic,strong) AMDataCenterViewModel *dataCenterViewModel;
/**
 数据中心列表
 */
@property (nonatomic,weak) UITableView *listView;


@end

@implementation AMDataCenterController

- (AMDataCenterViewModel *)dataCenterViewModel{
    if (!_dataCenterViewModel) {
        _dataCenterViewModel = [[AMDataCenterViewModel alloc] init];
    }
    return _dataCenterViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
}

/**
 设置界面
 */
- (void)setupView{
    self.navigationItem.title = @"数据中心";
    
    UITableView *listView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    listView.dataSource = self.dataCenterViewModel;
    listView.delegate = self.dataCenterViewModel;
    
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
