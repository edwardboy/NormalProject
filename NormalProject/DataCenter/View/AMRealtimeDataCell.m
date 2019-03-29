//
//  AMRealtimeDataCell.m
//  NormalProject
//
//  Created bygyh on 2019/3/25.
//  Copyright © 2019gyh. All rights reserved.
//

#import "AMRealtimeDataCell.h"

@interface AMRealtimeDataCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation AMRealtimeDataCell

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configTableViewCell];
    }
    return self;
}

- (void)configTableViewCell{
    
    [self.contentView addSubview:self.collectionView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, 182.0);
    
    
}


@end
