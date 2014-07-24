//
//  EFBNewPlayersViewController.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/23/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBUnknownPlayersView.h"
#import "EFBUnknownPlayerCell.h"
#import "EFBGame.h"

@interface EFBUnknownPlayersView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datSource;

@end

@implementation EFBUnknownPlayersView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.datSource = [NSMutableArray array];
        

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [self.collectionView registerClass:[EFBUnknownPlayerCell class] forCellWithReuseIdentifier:@"cell"];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)addPlayer:(EFBPlayer *)player
{
    NSIndexPath *indexPath = nil;
    NSUInteger index = [self.datSource indexOfObject:player];
    if (index != NSNotFound) {
        indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    }

    [self.collectionView performBatchUpdates:^{
        
        if (indexPath) {
            [self.datSource removeObject:player];
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }
        else {
            [self.datSource insertObject:player atIndex:0];
            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]]];
        }
        
    } completion:^(BOOL finished) {
     
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - CollectionView dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.datSource count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EFBUnknownPlayerCell *cell = (EFBUnknownPlayerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.player = [self.datSource objectAtIndex:indexPath.item];
    cell.delegate = self.delegate;
    
    return cell;
}


#pragma mark - Layout delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(260, CGRectGetHeight(self.bounds) - 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}


@end
