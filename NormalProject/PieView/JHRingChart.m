//
//  JHRingChart.m
//  JHChartDemo
//
//  Created by 简豪 on 16/7/5.
//  Copyright © 2016年 JH. All rights reserved.
//

#import "JHRingChart.h"
#import <Masonry/Masonry.h>
#define k_COLOR_STOCK @[[UIColor colorWithRed:1.000 green:0.783 blue:0.371 alpha:1.000], [UIColor colorWithRed:1.000 green:0.562 blue:0.968 alpha:1.000],[UIColor colorWithRed:0.313 green:1.000 blue:0.983 alpha:1.000],[UIColor colorWithRed:0.560 green:1.000 blue:0.276 alpha:1.000],[UIColor colorWithRed:0.239 green:0.651 blue:0.170 alpha:1.000]]
#define kColumns 4  // 默认展示每列4条


@interface AMTopTypeView : UIView
@property (nonatomic,weak) UIView *colorView;
@property (nonatomic,weak) UILabel *percentLabel;
@property (nonatomic,weak) UILabel *itemTitleLabel;

@end

@implementation AMTopTypeView

- (instancetype)initWithColor:(UIColor *)color percent:(NSString *)percent title:(NSString *)title frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView *colorView = [[UIView alloc] init];
        colorView.backgroundColor = color;
        self.colorView = colorView;
        [self addSubview:colorView];

        UILabel *percentLabel = [[UILabel alloc] init];
        percentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
        percentLabel.text = percent;
        self.percentLabel = percentLabel;
        [self addSubview:percentLabel];

        UILabel *itemTitleLabel = [[UILabel alloc] init];
        itemTitleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:10];
        itemTitleLabel.text = title;
        self.itemTitleLabel = itemTitleLabel;
        [self addSubview:itemTitleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(8));
        make.left.top.equalTo(self);
    }];

    [self.percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.colorView.mas_right).offset(6);
        make.top.equalTo(self.colorView);
        make.height.equalTo(@(15));
        make.right.equalTo(self);
    }];

    [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.percentLabel);
        make.top.equalTo(self.percentLabel.mas_bottom).offset(3);
        make.height.equalTo(@(12));
    }];
    
}
@end



@interface JHRingChart ()

//环图间隔 单位为π
@property (nonatomic,assign)CGFloat itemsSpace;

//数值和
@property (nonatomic,assign) CGFloat totolCount;

@property (nonatomic,assign) CGFloat redius;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) NSMutableArray *cusViews;
@end


@implementation JHRingChart

- (NSMutableArray *)cusViews{
    if (!_cusViews) {
        _cusViews = @[].mutableCopy;
    }
    return _cusViews;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    [self addSubview:self.titleLabel];
}


- (void)setItems:(NSArray<NSString *> *)items{
    _items = items;
    
    NSInteger count = items.count;
   
    for (int i = 0; i<count; i++) {
        UIColor *col = nil;
        NSString *percent = nil;
        if (i<_fillColorArray.count) {
            col = [_fillColorArray objectAtIndex:i];
        }
        if (i<_valueDataArr.count) {
            percent = [_valueDataArr objectAtIndex:i];
            percent = [NSString stringWithFormat:@"%.0f%%",percent.floatValue*100];
        }

        NSString *title = [items objectAtIndex:i];
        

        if (count <= 2 *kColumns) {
            AMTopTypeView *typeView = [[AMTopTypeView alloc] initWithColor:col percent:percent title:title frame:CGRectZero];
            [self addSubview:typeView];
            [self.cusViews addObject:typeView];

        }else {
            NSLog(@"类目太多，需要重新排列顺序，可自己调整");
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(-self.center.x/3);
        make.centerY.equalTo(self);
    }];
    
    for (int i = 0; i<_cusViews.count; i++) {
        NSInteger column = i/kColumns;
        NSInteger row = i%kColumns;

        CGFloat hMargin = 18;
        CGFloat height = 30;
        CGFloat vMargin = 15;
        CGFloat width = 54;
        CGFloat topMargin = (self.bounds.size.height - (kColumns-1)*(vMargin + height) - height)/2;

        AMTopTypeView *typeView = [_cusViews objectAtIndex:i];
        typeView.frame = CGRectMake(self.bounds.size.width - (hMargin+width)*(column+1), topMargin+(height+vMargin)*row, width, height);

    }
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.chartOrigin = CGPointMake(CGRectGetWidth(self.frame) / 3, CGRectGetHeight(self.frame)/2);
        _redius = (CGRectGetWidth(self.frame) -60*k_Width_Scale)/4;
        _ringWidth = 40;
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}


-(void)setValueDataArr:(NSArray *)valueDataArr{
    
    _valueDataArr = valueDataArr;
    
    [self configBaseData];
    
}

- (void)configBaseData{
    
    _totolCount = 0;
    _itemsSpace =  (M_PI * 2.0 * 10 / 360)/_valueDataArr.count ;
    for (id obj in _valueDataArr) {
        
        _totolCount += [obj floatValue];
        
    }

}



//开始动画
- (void)showAnimation{
    
    /*        动画开始前，应当移除之前的layer         */
//    for (CALayer *layer in self.layer.sublayers) {
//        [layer removeFromSuperlayer];
//        layer.backgroundColor = [UIColor redColor].CGColor;
//    }
    
//    [self.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [obj removeFromSuperlayer];
//    }];
//    NSLog(@"self.layer.sublayers:%@",self.layer.sublayers);
//    [self.layer.sublayers performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:0];
    
    
    CGFloat lastBegin = -M_PI/2;
    
    CGFloat totloL = 0;
    NSInteger  i = 0;
    for (id obj in _valueDataArr) {
        
        CAShapeLayer *layer = [CAShapeLayer layer] ;

        UIBezierPath *path = [UIBezierPath bezierPath];
        
        layer.fillColor = [UIColor clearColor].CGColor;
        
        if (i<_fillColorArray.count) {
            layer.strokeColor =[_fillColorArray[i] CGColor];
        }else{
             layer.strokeColor =[k_COLOR_STOCK[i%k_COLOR_STOCK.count] CGColor];
        }
        CGFloat cuttentpace = [obj floatValue] / _totolCount * (M_PI * 2 - _itemsSpace * _valueDataArr.count);
        totloL += [obj floatValue] / _totolCount;

        [path addArcWithCenter:self.chartOrigin radius:_redius startAngle:lastBegin  endAngle:lastBegin  + cuttentpace clockwise:YES];
        
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        layer.lineWidth = _ringWidth;
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        basic.fromValue = @(0);
        basic.toValue = @(1);
        basic.duration = 0.5;
        basic.fillMode = kCAFillModeForwards;
        
        [layer addAnimation:basic forKey:@"basic"];
        lastBegin += (cuttentpace+_itemsSpace);
        i++;

    }

}


-(void)drawRect:(CGRect)rect{
    
    
//    CGContextRef contex = UIGraphicsGetCurrentContext();
//
//    CGFloat lastBegin = 0;
//    CGFloat longLen = _redius +30*k_Width_Scale;
//    for (NSInteger i = 0; i<_valueDataArr.count; i++) {
//        id obj = _valueDataArr[i];
//        CGFloat currentSpace = [obj floatValue] / _totolCount * (M_PI * 2 - _itemsSpace * _valueDataArr.count);;
//        NSLog(@"%f",currentSpace);
//        CGFloat midSpace = lastBegin + currentSpace / 2;
//
//        CGPoint begin = CGPointMake(self.chartOrigin.x + sin(midSpace) * _redius, self.chartOrigin.y - cos(midSpace)*_redius);
//        CGPoint endx = CGPointMake(self.chartOrigin.x + sin(midSpace) * longLen, self.chartOrigin.y - cos(midSpace)*longLen);
//
//        NSLog(@"%@%@",NSStringFromCGPoint(begin),NSStringFromCGPoint(endx));
//        lastBegin += _itemsSpace + currentSpace;
    
//        UIColor *color;
//
//        if (_fillColorArray.count<_valueDataArr.count) {
//            color = k_COLOR_STOCK[i%k_COLOR_STOCK.count];
//        }else{
//            color = _fillColorArray[i];
//        }
        
//        [self drawLineWithContext:contex andStarPoint:begin andEndPoint:endx andIsDottedLine:NO andColor:color];
        
        
//        CGPoint secondP = CGPointZero;
//
//        CGSize size = [[NSString stringWithFormat:@"%.02f%c",[obj floatValue] / _totolCount * 100,'%'] boundingRectWithSize:CGSizeMake(200, 100) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10*k_Width_Scale]} context:nil].size;
//
//        if (midSpace<M_PI) {
//            secondP =CGPointMake(endx.x + 20*k_Width_Scale, endx.y);
//          [self drawText:[NSString stringWithFormat:@"%.02f%c",[obj floatValue] / _totolCount * 100,'%'] andContext:contex atPoint:CGPointMake(secondP.x + 3, secondP.y - size.height / 2) WithColor:color andFontSize:10*k_Width_Scale];
//
//        }else{
//             secondP =CGPointMake(endx.x - 20*k_Width_Scale, endx.y);
//            [self drawText:[NSString stringWithFormat:@"%.02f%c",[obj floatValue] / _totolCount * 100,'%'] andContext:contex atPoint:CGPointMake(secondP.x - size.width - 3, secondP.y - size.height/2) WithColor:color andFontSize:10*k_Width_Scale];
//        }
//          [self drawLineWithContext:contex andStarPoint:endx andEndPoint:secondP andIsDottedLine:NO andColor:color];
//        [self drawPointWithRedius:3*k_Width_Scale andColor:color andPoint:secondP andContext:contex];
       
//    }
    
    
    
    
}




@end
