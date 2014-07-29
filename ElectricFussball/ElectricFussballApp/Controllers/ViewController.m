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
    [self.dataService requestCurrentGame];
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype != UIEventSubtypeMotionShake) return;
    
    [self injectStep];
}

- (void)injectStep
{
    
    static NSMutableArray *_players;
    if (!_players) {
        _players = [NSMutableArray array];
    }
    
    switch (_players.count) {
        case 0:
        case 1:
        {
            NSLog(@"Post unknown player");
            
            NSDictionary *payload = @{@"team" : @"silver", @"rfid" : [NSString stringWithFormat:@"ios_%u_ios", arc4random()%9999], @"timestamp" : @([[NSDate date]timeIntervalSinceNow])};
            [self.dataService enqueRequestToPath:@"api/signatures/" ofType:@"POST" withPayload:payload];
            [_players addObject:payload[@"rfid"]];
            break;
        }
        case 2:
        {
            NSLog(@"Post a Game");
            
            NSDictionary *payload = @{@"silver_team" : _players[0], @"black_team" : _players[1], @"timestamp" : @([[NSDate date]timeIntervalSinceNow])};
            [self.dataService enqueRequestToPath:@"api/games/" ofType:@"POST" withPayload:payload];
            break;
        }
        default:
            NSLog(@"Resetting injection");
            [_players removeAllObjects];
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
    [self.dataService updateGame:self.gameView.game];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dataService requestCurrentGame];
    });
}

#pragma mark - Unknown view cell delegate

- (void)unknownPlayerCell:(EFBUnknownPlayerCell *)unknownPlayerCell didSubmitPlayer:(EFBPlayer *)player
{
    [self.dataService updatePlayer:player];
}

@end
