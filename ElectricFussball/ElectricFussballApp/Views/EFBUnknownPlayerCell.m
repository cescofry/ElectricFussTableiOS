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
        self.layer.cornerRadius = 6;
        self.layer.borderWidth = 2;
        
        frame = CGRectInset(self.bounds, 14, 4);
        frame.size.height = floor(CGRectGetHeight(frame) / 2);
        
        self.title = [[UILabel alloc] initWithFrame:frame];
        [self addSubview:self.title];
        
        [self prepareForReuse];
        
        frame.origin.y = frame.size.height;
        self.textField = [[UITextField alloc] initWithFrame:frame];
        self.textField.delegate = self;
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        [self addSubview:self.textField];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [tap setNumberOfTapsRequired:1];
        [tap setNumberOfTouchesRequired:1];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setPlayer:(EFBPlayer *)player
{
    _player = player;
    self.textField.placeholder = player.rfid;
    [self setAppearance];
}

- (void)setAppearance
{
    if (self.player.fullName.length > 0) {
        self.title.text = self.player.fullName;
        [self setBackgroundColor:[[UIColor greenColor] colorWithAlphaComponent:0.6]];
    }
    else if (self.player.alias.length > 0) {
        self.title.text = @"Waiting ...";
        [self setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.6]];
    }
    else {
        self.title.text = @"Unknown Player";
        [self setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.6]];
    }
}

- (void)prepareForReuse
{
    [self setAppearance];
}

- (void)didTap:(id)sender
{
    [self.textField becomeFirstResponder];
}

#pragma mark - Textfield Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length > 0 && [self.delegate respondsToSelector:@selector(unknownPlayerCell:didSubmitPlayer:)]) {
        self.player.alias = textField.text;
        [self.delegate unknownPlayerCell:self didSubmitPlayer:self.player];
        [self setAppearance];
        [self.textField resignFirstResponder];
    }
    return NO;
}

@end


@implementation EFBUnknownPlayerCellFlowLayout

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attr.transform = CGAffineTransformMakeTranslation(0, -100);
    
    return attr;
}

/*
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attr.transform = CGAffineTransformMakeTranslation(0, -100);
    
    return attr;
}
 */

@end
