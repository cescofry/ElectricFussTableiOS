//
//  EFBDataService.h
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFBGame.h"

@protocol EFBDataServiceDelegate;
@interface EFBDataService : NSObject

@property(nonatomic, weak, readonly) id<EFBDataServiceDelegate> delegate;

- (instancetype)initWithDelegate:(id<EFBDataServiceDelegate>)delegate;
- (void)updateScore:(NSUInteger)score forTeamType:(EFBTeamType)type;

@end


@protocol EFBDataServiceDelegate <NSObject>

- (void)dataService:(EFBDataService *)dataService didReceiveUpdatedGame:(EFBGame *)game;

@end
