//
//  CollectionController.m
//  NSOperaton
//
//  Created by Yang Mr on 2018/3/8.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import "CollectionController.h"
#import "CustomeCollectionLayout.h"
#import "CollectionViewCell.h"

#define COLLECTION_VIEW_CELL_REUSE @"collectionViewCellReuseIdentifier"

@interface CollectionController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**<#statements#>*/
@property (nonatomic, strong) UICollectionView * collectionView;
/**<#statements#>*/
@property (nonatomic, strong) NSMutableArray * dataModels;
@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CustomeCollectionLayout *layout = [[CustomeCollectionLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:COLLECTION_VIEW_CELL_REUSE];
    
    _dataModels = [NSMutableArray array];
    for (int i = 0;i < 10; i++) {
        [_dataModels addObject:@""];
    }
    [_collectionView reloadData];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_VIEW_CELL_REUSE forIndexPath:indexPath];
    
    return cell;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataModels.count;
}

@end
