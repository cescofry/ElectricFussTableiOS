//
//  EFBGameViewController.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBGameViewController.h"

@implementation EFBGameViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataService = [[EFBDataService alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - Data service Delegate

- (void)dataService:(EFBDataService *)dataService didReceiveUpdatedGame:(EFBGame *)game
{
    self.gameView.game = game;
}

@end
