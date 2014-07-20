//
//  EFBTeamView.h
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EFBTeam;
@protocol EFBiOSScoreViewDelegate;

@interface EFBiOSTeamView : UIView

@property (nonatomic, strong) EFBTeam *team;
@property (nonatomic, weak) id<EFBiOSScoreViewDelegate> scoreDelegate;

@end
