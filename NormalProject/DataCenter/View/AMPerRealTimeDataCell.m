//
//  AMPerRealTimeDataCell.m
//  NormalProject
//
//  Created by 李宁锋 on 2019/3/25.
//  Copyright © 2019 李宁锋. All rights reserved.
//

#import "AMPerRealTimeDataCell.h"

@interface AMPerRealTimeDataCell()

/** 数据内容 */
@property (nonatomic,weak) UILabel *dataLabel;

/** 数据简介 */
@property (nonatomic,weak) UILabel *dataIntroduceLabel;

/** 昨日数据 */
@property (nonatomic,weak) UILabel *dataYesterdayLabel;

@end

@implementation AMPerRealTimeDataCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)configDataCell{
//    UILabel *dataLabel = [UILabel ];
}


@end
