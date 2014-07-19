//
//  EFBGameViewController.h
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFBDataService.h"
#import "EFBGameView.h"

@interface EFBGameViewController : NSObject <EFBDataServiceDelegate>

@property (nonatomic, strong) EFBDataService *dataService;
@property (nonatomic, strong) IBOutlet EFBGameView *gameView;

@end
