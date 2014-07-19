//
//  EFBTeamView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBTeamView.h"
#import "EFBUserView.h"

@interface EFBTeamView ()

@property (nonatomic, strong) EFBUserView *user1View;
@property (nonatomic, strong) EFBUserView *user2View;

@property (nonatomic, strong) IBOutlet NSTextField *scoreLbl;

@end

@implementation EFBTeamView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        float quarter = frame.size.height / 4;
        NSRect rect = NSMakeRect(0, 0, frame.size.width, quarter);
        self.user1View = [[EFBUserView alloc] initWithFrame:rect];
        [self addSubview:self.user1View];
        
        rect.origin.y += quarter;
        self.user2View = [[EFBUserView alloc] initWithFrame:rect];
        [self addSubview:self.user2View];
        
        rect.origin.y += quarter;
        rect.size.height = (quarter * 2);
        self.scoreLbl = [[NSTextField alloc] initWithFrame:rect];
        [self.scoreLbl setEditable:NO];
        [self addSubview:self.scoreLbl];
        
    }
    return self;
}

- (void)setTeam:(EFBTeam *)team
{
    _team = team;
    self.user1View.user = team.user1;
    self.user2View.user = team.user2;
    self.scoreLbl.stringValue = [NSString stringWithFormat:@"%ld", team.currentScore];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
