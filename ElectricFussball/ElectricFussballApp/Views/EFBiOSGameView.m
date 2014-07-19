//
//  EFBGameView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBiOSGameView.h"
#import "EFBiOSTeamView.h"
#import "EFBGame.h"

@interface EFBiOSGameView ()

@property (nonatomic, strong) EFBiOSTeamView *redTeamView;
@property (nonatomic, strong) EFBiOSTeamView *blueTeamView;
@property (nonatomic, strong) UILabel *finalScoreLbl;

@end

@implementation EFBiOSGameView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float w = CGRectGetWidth(self.bounds) /2;
        self.redTeamView = [[EFBiOSTeamView alloc] initWithFrame:CGRectMake(0, 0, w, CGRectGetHeight(self.bounds))];
        [self addSubview:self.redTeamView];

        self.blueTeamView = [[EFBiOSTeamView alloc] initWithFrame:CGRectMake(w, 0, w, CGRectGetHeight(self.bounds))];
        [self addSubview:self.blueTeamView];
                
#warning Add finalScore here
    }
    return self;
}

- (void)setGame:(EFBGame *)game
{
    _game = game;
    
    EFBTeam *redTeam = (_game.team1.type == EFBTeamTypeRed)? _game.team1 : _game.team2;
    EFBTeam *blueTeam = (_game.team1.type == EFBTeamTypeBlue)? _game.team1 : _game.team2;
    
    self.redTeamView.team = redTeam;
    self.blueTeamView.team = blueTeam;
    
}

@end
