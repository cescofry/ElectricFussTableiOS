//
//  EFBiOSScoreView.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBiOSScoreView.h"
#import "EFBGame.h"

@interface EFBiOSScoreView ()

@property (nonatomic, assign) NSInteger score;
@property (nonatomic, strong) UIColor *color;

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
        
        UISwipeGestureRecognizer *swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
        [swipeUpGesture setNumberOfTouchesRequired:1];
        [swipeUpGesture setDirection:UISwipeGestureRecognizerDirectionUp];
        [self addGestureRecognizer:swipeUpGesture];

        UISwipeGestureRecognizer *swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
        [swipeDownGesture setNumberOfTouchesRequired:1];
        [swipeDownGesture setDirection:UISwipeGestureRecognizerDirectionDown];
        [self addGestureRecognizer:swipeDownGesture];
        
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

- (void)animateScore:(NSUInteger)score isUp:(BOOL)isUp
{
    
    CGFloat h = CGRectGetHeight(self.bounds);
    float preTrasofrm = (isUp)? h : -h;
    float endTransform = (isUp)? -h : h;
    float bounceTransform = (isUp)? -20 : 20;
    
    UILabel *nextScoreLbl = [self generateScoreLabel];
    nextScoreLbl.textColor = self.color;
    nextScoreLbl.transform = CGAffineTransformMakeTranslation(0, preTrasofrm);
    nextScoreLbl.text = [self textFromScore:score];
    [self addSubview:nextScoreLbl];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        nextScoreLbl.transform = CGAffineTransformMakeTranslation(0, bounceTransform);
        self.scoreLbl.transform = CGAffineTransformMakeTranslation(0, endTransform);
    } completion:^(BOOL finished) {
        [self.scoreLbl removeFromSuperview];
        self.scoreLbl = nextScoreLbl;
        [UIView animateWithDuration:0.2 animations:^{
            self.scoreLbl.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }];
    
}


- (void)setTeam:(EFBTeam *)team
{
    _team = team;
    self.color = (_team.type == EFBTeamTypeRed)? [UIColor redColor] : [UIColor blueColor];
    self.score = _team.currentScore;
    
}

- (void)setScore:(NSInteger)score
{
    if (score < 0) {
        return;
    }
    NSInteger diff = (score - _score);
    _score = score;
    
    if (_score == 0) {
        self.scoreLbl.text = [self textFromScore:_score];
        return;
    }
    
    if (diff != 0) {
        [self animateScore:_score isUp:(diff < 0)];
    }
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    self.scoreLbl.textColor = color;
}

#pragma mark -actions

- (void)didSwipe:(UISwipeGestureRecognizer *)swipeGesture
{
    BOOL isUp = swipeGesture.direction == UISwipeGestureRecognizerDirectionUp;
    if (isUp) {
        self.score--;
    }
    else {
        self.score++;
    }
    
#error Delegate Not Attached yet!
    if ([self.delegate respondsToSelector:@selector(scoreView:didSwipeToScore:)]) {
        [self.delegate scoreView:self didSwipeToScore:self.score];
    }
}

@end
