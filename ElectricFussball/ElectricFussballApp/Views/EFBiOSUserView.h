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
@protocol EFBiOSUserViewDelegate;
@interface EFBiOSUserView : UIView

@property (nonatomic, strong) EFBUser *user;
@property (nonatomic, weak) id<EFBiOSScoreViewDelegate> scoreDelegate;
@property (nonatomic, weak) id<EFBiOSUserViewDelegate> delegate;

@end


@protocol EFBiOSUserViewDelegate <NSObject>

- (void)userView:(EFBiOSUserView *)userView didTapOnUser:(EFBUser *)user;

@end