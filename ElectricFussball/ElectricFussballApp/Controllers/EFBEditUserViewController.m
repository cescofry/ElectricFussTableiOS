//
//  EFBEditUserViewController.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/20/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBEditUserViewController.h"

@interface EFBEditUserViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;

@end

@implementation EFBEditUserViewController

-(void)setUser:(EFBPlayer *)user
{
    _user = user;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect rect = self.view.frame;
    rect.size.height = 60;
    rect.origin.y = 40;
    rect = CGRectInset(rect, 10, 10);
    
    self.textField = [[UITextField alloc] initWithFrame:rect];
    self.textField.placeholder = @"Enter your Microsoft Alias";
    self.textField.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:self.textField];
    
    rect.origin.y += rect.size.height + 10;
    self.button  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame = rect;
    [self.button addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:@"Submit" forState:UIControlStateNormal];
    
    [self.view addSubview:self.button];

}

- (void)submit:(id)sender
{
    if (self.textField.text.length > 0) {
        //send
        NSLog(@"submit: %@", self.textField.text);
//#error submit form here
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
