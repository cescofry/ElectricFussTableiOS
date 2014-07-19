//
//  EFBUserView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBiOSUserView.h"
#import "EFBGame.h"

@interface EFBiOSUserView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation EFBiOSUserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float h = CGRectGetHeight(frame);
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, h, h)];
        [self addSubview:self.imageView];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(h, 0, CGRectGetWidth(frame) - h, h)];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        self.layer.borderWidth = 1.0;
    }
    return self;
}

- (void)setUser:(EFBUser *)user
{
    _user = user;
    self.label.text = user.fullName;
    
}

@end
