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

@property (nonatomic, strong) EFBiOSTeamView *silverTeamView;
@property (nonatomic, strong) EFBiOSTeamView *blackTeamView;
@property (nonatomic, strong) UILabel *finalScoreLbl;

@end

@implementation EFBiOSGameView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[EFBColor efb_grassBkgColor]];
        
        self.finalScoreLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.bounds), finalScoreH)];
        [self.finalScoreLbl setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.finalScoreLbl];
        
        float w = CGRectGetWidth(self.bounds) /2;
        float h = CGRectGetHeight(self.bounds) - finalScoreH;
        self.silverTeamView = [[EFBiOSTeamView alloc] initWithFrame:CGRectMake(0, finalScoreH, w, h)];
        [self addSubview:self.silverTeamView];

        self.blackTeamView = [[EFBiOSTeamView alloc] initWithFrame:CGRectMake(w, finalScoreH, w, h)];
        [self addSubview:self.blackTeamView];
        
    }
    return self;
}

- (void)setGame:(EFBGame *)game
{
    _game = game;
    
    self.silverTeamView.team = _game.silverTeam;
    self.blackTeamView.team = _game.blackTeam;
    
    self.finalScoreLbl.text = [NSString stringWithFormat:@"This game ends at %ld", (unsigned long)_game.finalScore];
    
}

- (void)setScoreDelegate:(id<EFBiOSScoreViewDelegate,EFBiOSUserViewDelegate>)scoreDelegate
{
    [self.silverTeamView setScoreDelegate:scoreDelegate];
    [self.blackTeamView setScoreDelegate:scoreDelegate];
}

- (void)layoutSubviews
{
    float w = CGRectGetWidth(self.bounds) /2;
    float h = CGRectGetHeight(self.bounds) - finalScoreH;
    [self.silverTeamView setFrame:CGRectMake(0, finalScoreH, w, h)];
    [self.blackTeamView setFrame:CGRectMake(w, finalScoreH, w, h)];
}

@end
