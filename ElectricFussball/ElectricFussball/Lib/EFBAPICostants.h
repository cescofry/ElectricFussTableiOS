//
//  EFBAPICostants.h
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const EFBBaseURL = @"http://electric-foos.cloudapp.net";
static NSString *const EFBBaseAPIKey = @"Token token=<TOKEN>";
static const NSInteger EFBSocketPort = 7640;

static NSString *const EFBUpdatePlayerPath = @"api/players/";
static NSString *const EFBUpdateCurrentGamePath = @"api/games/current/";
static NSString *const EFBUpdateGamePath_ = @"api/games/%@/";
