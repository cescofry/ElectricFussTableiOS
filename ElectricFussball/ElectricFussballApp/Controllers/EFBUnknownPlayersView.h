//
//  EFBNewPlayersViewController.h
//  ElectricFussball
//
//  Created by Francesco Frison on 7/23/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EFBPlayer;
@protocol EFBUnknownPlayerCellDelegate;
@interface EFBUnknownPlayersView : UIView

@property (nonatomic, weak) id<EFBUnknownPlayerCellDelegate> delegate;

- (void)addPlayer:(EFBPlayer *)player;

@end
