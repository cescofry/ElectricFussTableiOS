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
#import "EFBColor.h"

@interface EFBiOSUserView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation EFBiOSUserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[EFBColor efb_cellBkgColor]];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.image = [UIImage imageNamed:@"user"];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.imageView];
        
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.numberOfLines = 0;
        self.label.textAlignment = NSTextAlignmentLeft;
        [self.label setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.label];
        
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [self addGestureRecognizer:self.tapGesture];
        
    }
    return self;
}

- (void)setUser:(EFBUser *)user
{
    _user = user;
    self.label.text = (user.fullName.length > 0)? user.fullName : user.rfid;
    
    
    [EFBImageDataSource imageAtURL:user.mugshotURL completionBlock:^(NSData *data) {
        self.imageView.image = [UIImage imageWithData:data];
    }];
    
}

- (void)layoutSubviews
{
    float h = CGRectGetHeight(self.bounds);
    [self.imageView setFrame:CGRectMake(0, 0, h, h)];
    
    float padding = 20;
    [self.label setFrame:CGRectMake(h + padding, 0, CGRectGetWidth(self.bounds) - h - (padding * 2), h)];
    self.label.font = [UIFont systemFontOfSize:(h / 4)];
}

- (void)didTap:(UITapGestureRecognizer *)sender {
#warning this shouldn't be here.
    //if (self.user.fullName.length > 0) return;
    
    if ([self.delegate respondsToSelector:@selector(userView:didTapOnUser:)]) {
        [self.delegate userView:self didTapOnUser:self.user];
    }
}

@end
