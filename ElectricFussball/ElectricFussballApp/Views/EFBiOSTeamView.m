//
//  EFBTeamView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBiOSTeamView.h"
#import "EFBGame.h"
#import "EFBiOSUserView.h"
#import "EFBiOSScoreView.h"

@interface EFBiOSTeamView ()

@property (nonatomic, strong) EFBiOSScoreView *scoreLabel;
@property (nonatomic, strong) EFBiOSUserView *user1View;
@property (nonatomic, strong) EFBiOSUserView *user2View;

@end

@implementation EFBiOSTeamView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        float quarter = CGRectGetHeight(frame) / 4;
        CGRect rect = self.bounds;
        rect.size.height = (quarter * 2);
        
        self.scoreLabel = [[EFBiOSScoreView alloc] initWithFrame:rect];
        [self addSubview:self.scoreLabel];
        
        rect.origin.y += rect.size.height;
        rect.size.height = quarter;
        self.user1View = [[EFBiOSUserView alloc] initWithFrame:rect];
        [self addSubview:self.user1View];
        
        rect.origin.y += quarter;
        self.user2View = [[EFBiOSUserView alloc] initWithFrame:rect];
        [self addSubview:self.user2View];
        
    }
    return self;
}

- (void)setTeam:(EFBTeam *)team
{
    _team = team;
    
    self.scoreLabel.color = (_team.type == EFBTeamTypeRed)? [UIColor redColor] : [UIColor blueColor];
    self.scoreLabel.score = _team.currentScore;
    
    self.user1View.user = _team.user1;
    self.user2View.user = _team.user2;
}

@end
