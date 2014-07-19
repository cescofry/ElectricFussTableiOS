//
//  EFBAppDelegate.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBAppDelegate.h"
#import "EFBGameViewController.h"

@interface EFBAppDelegate ()

@property (nonatomic, strong) EFBGameViewController *gameViewController;

@end

@implementation EFBAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.gameViewController = [[EFBGameViewController alloc] init];
}


@end
