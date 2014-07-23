//
//  EFBUnknownPlayerCell.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/23/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBUnknownPlayerCell.h"
#import "EFBGame.h"

@interface EFBUnknownPlayerCell ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation EFBUnknownPlayerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor redColor]];
        
        frame = self.bounds;
        frame.size.height = floor(CGRectGetHeight(frame) / 2);
        self.textField = [[UITextField alloc] initWithFrame:frame];
        [self addSubview:self.textField];
        
        frame.origin.y = frame.size.height;
        self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sendButton setFrame:frame];
        [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
    }
    return self;
}

- (void)setPlayer:(EFBPlayer *)player
{
    _player = player;
    self.textField.placeholder = player.rfid;
}

@end
