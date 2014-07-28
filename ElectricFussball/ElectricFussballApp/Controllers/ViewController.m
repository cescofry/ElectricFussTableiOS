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
#import "EFBiOSUserView.h"
#import "EFBUnknownPlayersView.h"
#import "EFBUnknownPlayerCell.h"

@interface ViewController () <EFBDataServiceDelegate, EFBiOSScoreViewDelegate, EFBiOSUserViewDelegate, EFBUnknownPlayerCellDelegate>

@property (nonatomic, strong) EFBDataService *dataService;
@property (nonatomic, strong) EFBiOSGameView *gameView;
@property (nonatomic, strong) EFBUnknownPlayersView *unknownPlayersView;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataService = [[EFBDataService alloc] initWithDelegate:self];
    self.gameView = [[EFBiOSGameView alloc] initWithFrame:self.view.bounds];
    [self.gameView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    self.gameView.scoreDelegate = self;
    
    [self.view addSubview:self.gameView];
    
    self.unknownPlayersView = [[EFBUnknownPlayersView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    [self.unknownPlayersView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    self.unknownPlayersView.delegate = self;
    [self.view addSubview:self.unknownPlayersView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype != UIEventSubtypeMotionShake) return;
    
    [self injectStep];
}

- (void)injectStep
{
    static int _step = 0;
    _step++;
    
    switch (_step) {
        case 1:
        case 2:
        {
            NSLog(@"Post unknown player");
            NSString *payload = [NSString stringWithFormat:@"team=silver&rfid=t%ut&timestamp=%f", arc4random()%9999, [[NSDate date]timeIntervalSinceNow]];
            [self.dataService enqueRequestToPath:@"api/signatures/" withPayload:payload];
            break;
        }
        default:
            NSLog(@"Resetting injection");
            _step = 0;
            break;
    }
    

}

#pragma mark - data servide

- (void)dataService:(EFBDataService *)dataService didReceiveUpdatedGame:(EFBGame *)game
{
    self.gameView.game = game;
}

- (void)dataService:(EFBDataService *)dataService didReceiveUpdatedPlayer:(EFBPlayer *)player
{
    [self.unknownPlayersView addPlayer:player];
}

#pragma mark - ScoreView Delegate

- (void)scoreView:(EFBiOSScoreView *)scoreView didSwipeToScore:(NSUInteger)score
{
    NSLog(@"%ld changed to %ld", scoreView.team.type, score);
    [self.dataService updateTeam:scoreView.team onGameID:self.gameView.game.gameID];
}

#pragma mark - Unknown view cell delegate

- (void)unknownPlayerCell:(EFBUnknownPlayerCell *)unknownPlayerCell didSubmitPlayer:(EFBPlayer *)player
{
    [self.dataService updatePlayer:player];
}

@end
