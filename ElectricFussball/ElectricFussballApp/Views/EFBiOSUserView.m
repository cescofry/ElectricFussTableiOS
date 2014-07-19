//
//  EFBUserView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBiOSUserView.h"
#import "EFBGame.h"
#import "EFBImageDataSource.h"

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
        self.imageView.image = [UIImage imageNamed:@"user"];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.imageView];
        
        float padding = 20;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(h + padding, 0, CGRectGetWidth(frame) - h - (padding * 2), h)];
        self.label.numberOfLines = 0;
        self.label.font = [UIFont systemFontOfSize:(h / 4)];
        self.label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.label];
        
        self.layer.borderWidth = 1.0;
    }
    return self;
}

- (void)setUser:(EFBUser *)user
{
    _user = user;
    self.label.text = user.fullName;
    
    [EFBImageDataSource imageAtURL:user.mugshotURL completionBlock:^(NSData *data) {
        self.imageView.image = [UIImage imageWithData:data];
    }];
    
}

@end
