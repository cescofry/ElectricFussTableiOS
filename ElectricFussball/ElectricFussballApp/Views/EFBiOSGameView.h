//
//  EFBGameView.h
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EFBGame;
@protocol EFBiOSScoreViewDelegate;
@protocol EFBiOSUserViewDelegate;
@interface EFBiOSGameView : UIView

@property (nonatomic, strong) EFBGame *game;
@property (nonatomic, weak) id<EFBiOSScoreViewDelegate, EFBiOSUserViewDelegate> scoreDelegate;

@end
