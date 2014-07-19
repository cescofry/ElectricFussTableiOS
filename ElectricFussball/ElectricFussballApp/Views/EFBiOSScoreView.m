//
//  EFBiOSScoreView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBiOSScoreView.h"

@interface EFBiOSScoreView ()

@property (nonatomic, strong) UILabel *scoreLbl;

@end

@implementation EFBiOSScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scoreLbl = [self generateScoreLabel];
        [self addSubview:self.scoreLbl];
        [self setClipsToBounds:YES];
        
        [self setScore:0];
    }
    return self;
}

- (UILabel *)generateScoreLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:CGRectGetHeight(self.bounds)];
    label.layer.shadowRadius = 2;
    label.layer.shadowOffset = CGSizeMake(2, 2);
    label.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    label.layer.shadowOpacity = 1.0;
    
    return label;
}

- (NSString *)textFromScore:(NSUInteger)score
{
    return [NSString stringWithFormat:@"%ld", (unsigned long)score];
}

- (void)animateScore:(NSUInteger)score
{
    
    CGFloat h = CGRectGetHeight(self.bounds);

    UILabel *nextScoreLbl = [self generateScoreLabel];
    nextScoreLbl.textColor = self.color;
    nextScoreLbl.transform = CGAffineTransformMakeTranslation(0, h);
    nextScoreLbl.text = [self textFromScore:score];
    [self addSubview:nextScoreLbl];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        nextScoreLbl.transform = CGAffineTransformMakeTranslation(0, -20);
        self.scoreLbl.transform = CGAffineTransformMakeTranslation(0, -h);
    } completion:^(BOOL finished) {
        [self.scoreLbl removeFromSuperview];
        self.scoreLbl = nextScoreLbl;
        [UIView animateWithDuration:0.2 animations:^{
            self.scoreLbl.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }];
    
}

- (void)setScore:(NSUInteger)score
{
    BOOL shouldAnimate = (_score != score);
    _score = score;
    
    if (_score == 0) {
        self.scoreLbl.text = [self textFromScore:_score];
        return;
    }
    
    if (shouldAnimate) {
        [self animateScore:_score];
    }
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    self.scoreLbl.textColor = color;
}

@end