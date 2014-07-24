//
//  EFBUnknownPlayerCell.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/23/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBUnknownPlayerCell.h"
#import "EFBGame.h"

@interface EFBUnknownPlayerCell () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *title;

@end

@implementation EFBUnknownPlayerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.6]];
        self.layer.cornerRadius = 6;
        self.layer.borderWidth = 2;
        
        frame = CGRectInset(self.bounds, 14, 4);
        frame.size.height = floor(CGRectGetHeight(frame) / 2);
        
        self.title = [[UILabel alloc] initWithFrame:frame];
        [self.title setText:@"Unknown Player"];
        [self addSubview:self.title];
        
        frame.origin.y = frame.size.height;
        self.textField = [[UITextField alloc] initWithFrame:frame];
        self.textField.delegate = self;
        [self addSubview:self.textField];
        

    }
    return self;
}

- (void)setPlayer:(EFBPlayer *)player
{
    _player = player;
    self.textField.placeholder = player.rfid;
    if (player.fullName.length > 0) {
        self.title.text = player.fullName;
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.title setText:@"Unknown Player"];
}

#pragma mark - Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0 && [self.delegate respondsToSelector:@selector(unknownPlayerCell:didSubmitPlayer:)]) {
        self.player.alias = textField.text;
        [self.delegate unknownPlayerCell:self didSubmitPlayer:self.player];
    }
    return NO;
}

@end
