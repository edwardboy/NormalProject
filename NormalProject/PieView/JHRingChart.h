//
//  JHRingChart.h
//  JHChartDemo
//
//  Created by 简豪 on 16/7/5.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHChart.h"

@interface JHRingChart : JHChart
#define k_Width_Scale  (self.frame.size.width / [UIScreen mainScreen].bounds.size.width)
/**
 *  titles of all items
 */
@property (nonatomic,strong) NSArray <NSString *> *items;


/**
 *  Data source Array
 */
@property (nonatomic, strong) NSArray * valueDataArr;


/**
 *  An array of colors in the loop graph
 */
@property (nonatomic, strong) NSArray * fillColorArray;


/**
 *  Ring Chart width
 */
@property (nonatomic, assign) CGFloat ringWidth;

/**
 *  Ring Chart title
 */
@property (nonatomic, copy) NSString *title;
@end
