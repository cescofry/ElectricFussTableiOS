//
//  ViewController.m
//  ElectricFussballApp
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "ViewController.h"
#import "EFBDataService.h"
#import "EFBiOSGameView.h"
#import "EFBiOSScoreView.h"

@interface ViewController () <EFBDataServiceDelegate, EFBiOSScoreViewDelegate>

@property (nonatomic, strong) EFBDataService *dataService;
@property (nonatomic, strong) EFBiOSGameView *gameView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataService = [[EFBDataService alloc] initWithDelegate:self];
    self.gameView = [[EFBiOSGameView alloc] initWithFrame:self.view.bounds];
    [self.gameView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    self.gameView.scoreDelegate = self;
    
    [self.view addSubview:self.gameView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data servide

- (void)dataService:(EFBDataService *)dataService didReceiveUpdatedGame:(EFBGame *)game
{
    self.gameView.game = game;
}

#pragma mark - ScoreView Delegate

- (void)scoreView:(EFBiOSScoreView *)scoreView didSwipeToScore:(NSUInteger)score
{
    NSLog(@"%ld changed to %ld", scoreView.team.type, score);
}

@end
