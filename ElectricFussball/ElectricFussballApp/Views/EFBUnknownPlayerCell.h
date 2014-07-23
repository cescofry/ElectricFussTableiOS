//
//  EFBUnknownPlayerCell.h
//  ElectricFussball
//
//  Created by Francesco Frison on 7/23/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EFBPlayer;
@protocol EFBUnknownPlayerCellDelegate;
@interface EFBUnknownPlayerCell : UICollectionViewCell

@property (nonatomic, strong) EFBPlayer *player;
@property (nonatomic, weak) id<EFBUnknownPlayerCellDelegate> delegate;

@end


@protocol EFBUnknownPlayerCellDelegate <NSObject>

- (void)unknownPlayerCell:(EFBUnknownPlayerCell *)unknownPlayerCell didSubmitPlayer:(EFBPlayer *)player;

@end