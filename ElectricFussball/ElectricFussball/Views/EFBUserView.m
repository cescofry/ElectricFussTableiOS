//
//  EFBUserView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBUserView.h"
#import "EFBLabel.h"

@interface EFBUserView ()

@property (nonatomic, strong) EFBLabel *fullNameLbl;
@property (nonatomic, strong) NSImageView *imageView;

@end

@implementation EFBUserView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        float h = frame.size.height;

        self.imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, h, h)];
        [self.imageView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
        [self addSubview:self.imageView];
        
        self.fullNameLbl = [[EFBLabel alloc] initWithFrame:NSMakeRect(h, 0, frame.size.width - h, h)];
        [self.fullNameLbl setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable|NSViewMinXMargin];
        self.fullNameLbl.font = [NSFont systemFontOfSize:h/4];
        [self addSubview:self.fullNameLbl];
    }
    return self;
}

- (void)setUser:(EFBUser *)user
{
    _user = user;
    self.fullNameLbl.stringValue = _user.fullName;
    
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
