//
//  EFBAppDelegate.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBAppDelegate.h"
#import "EFBDataService.h"

@interface EFBAppDelegate () <EFBDataServiceDelegate>

@property (nonatomic, strong) EFBDataService *dataService;

@end

@implementation EFBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.dataService = [[EFBDataService alloc] initWithDelegate:self];
}

#pragma mark - Data service Delegate

- (void)dataService:(EFBDataService *)dataService didReceiveUpdatedGame:(EFBGame *)game
{
    
}

@end
