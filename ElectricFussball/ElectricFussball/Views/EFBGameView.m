//
//  EFBGameView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBGameView.h"
#import "EFBTeamView.h"

@interface EFBGameView ()

@property (nonatomic, strong) EFBTeamView *redTeamView;
@property (nonatomic, strong) EFBTeamView *blueTeamView;
@property (nonatomic, strong) NSTextView *totalScoreLbl;
@end

@implementation EFBGameView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        float w = (frame.size.width / 2);
        
        self.redTeamView = [[EFBTeamView alloc] initWithFrame:NSMakeRect(0, 0, w, frame.size.height)];
        [self addSubview:self.redTeamView];
        
        self.blueTeamView = [[EFBTeamView alloc] initWithFrame:NSMakeRect(w, 0, w, frame.size.height)];
        [self addSubview:self.blueTeamView];
        
    }
    return self;
}

- (void)setGame:(EFBGame *)game
{
    EFBTeam *redTeam = (game.team1.type == EFBTeamTypeRed)? game.team1 : game.team2;
    EFBTeam *blueTeam = (game.team1.type == EFBTeamTypeBlue)? game.team1 : game.team2;
    
    self.redTeamView.team = redTeam;
    self.blueTeamView.team = blueTeam;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
