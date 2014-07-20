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
#import "EFBColor.h"

static const CGFloat finalScoreH = 30.0;

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
        
        [self setBackgroundColor:[EFBColor efb_grassBkgColor]];
        
        self.finalScoreLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), finalScoreH)];
        [self.finalScoreLbl setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.finalScoreLbl];
        
        float w = CGRectGetWidth(self.bounds) /2;
        float h = CGRectGetHeight(self.bounds) - finalScoreH;
        self.redTeamView = [[EFBiOSTeamView alloc] initWithFrame:CGRectMake(0, finalScoreH, w, h)];
        [self addSubview:self.redTeamView];

        self.blueTeamView = [[EFBiOSTeamView alloc] initWithFrame:CGRectMake(w, finalScoreH, w, h)];
        [self addSubview:self.blueTeamView];
        
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
    
//    self.finalScoreLbl.text = [NSString stringWithFormat:@"This game ends at %ld", (unsigned long)_game.finalScore];
    
}

- (void)layoutSubviews
{
    float w = CGRectGetWidth(self.bounds) /2;
    float h = CGRectGetHeight(self.bounds) - finalScoreH;
    [self.redTeamView setFrame:CGRectMake(0, finalScoreH, w, h)];
    [self.blueTeamView setFrame:CGRectMake(w, finalScoreH, w, h)];
}

@end
