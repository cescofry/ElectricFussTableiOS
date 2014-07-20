//
//  EFBUserView.h
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EFBUser;
@protocol EFBiOSScoreViewDelegate;
@interface EFBiOSUserView : UIView

@property (nonatomic, strong) EFBUser *user;
@property (nonatomic, weak) id<EFBiOSScoreViewDelegate> scoreDelegate;

@end
