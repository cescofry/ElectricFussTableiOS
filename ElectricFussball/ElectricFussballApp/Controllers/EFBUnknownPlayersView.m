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
        

        EFBUnknownPlayerCellFlowLayout *layout = [[EFBUnknownPlayerCellFlowLayout alloc] init];
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


- (NSIndexPath *)playerIndexPath:(EFBPlayer *)player
{
    NSIndexPath *indexPath = nil;
    NSUInteger index = [self.datSource indexOfObject:player];
    if (index != NSNotFound) {
        indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    }
    
    return indexPath;
}

- (void)animatePlayer:(EFBPlayer *)player atIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView performBatchUpdates:^{
        
        if (indexPath) {
            [self.datSource removeObject:player];
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }
        else {
            [self.datSource addObject:player];
            [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:(self.datSource.count - 1) inSection:0]]];
        }
    } completion:NULL];
}

- (void)addPlayer:(EFBPlayer *)player
{
    NSIndexPath *indexPath = [self playerIndexPath:player];

    if (indexPath) {
        EFBUnknownPlayerCell *cell = (EFBUnknownPlayerCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [cell setPlayer:player];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animatePlayer:player atIndexPath:indexPath];
        });
    }
    else {
        [self animatePlayer:player atIndexPath:indexPath];
    }
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
    CGRect frame = self.bounds;
    frame.size.height -= 40;
    frame.size.width = (CGRectGetWidth(frame) / 4) - 20;
    return frame.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}



@end
