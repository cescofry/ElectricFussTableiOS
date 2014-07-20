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
        
        self.scoreLabel = [[EFBiOSScoreView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.scoreLabel];

        self.user1View = [[EFBiOSUserView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.user1View];
        
        self.user2View = [[EFBiOSUserView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.user2View];
        
    }
    return self;
}

- (void)setTeam:(EFBTeam *)team
{
    _team = team;
    
    self.scoreLabel.team = _team;
    self.user1View.user = _team.user1;
    self.user2View.user = _team.user2;
}

- (void)setScoreDelegate:(id<EFBiOSScoreViewDelegate,EFBiOSUserViewDelegate>)scoreDelegate
{
    [self.scoreLabel setDelegate:scoreDelegate];
    self.user1View.delegate = scoreDelegate;
    self.user2View.delegate = scoreDelegate;
}

- (void)layoutSubviews
{
    float quarter = CGRectGetHeight(self.bounds) / 4;
    CGRect rect = self.bounds;
    rect.size.height = (quarter * 2);

    [self.scoreLabel setFrame:rect];
    
    rect.origin.y += rect.size.height;
    rect.size.height = quarter;
    [self.user1View setFrame:rect];

    
    rect.origin.y += quarter;
    [self.user2View setFrame:rect];
    
    [self.scoreLabel forceLayout];
}

@end
