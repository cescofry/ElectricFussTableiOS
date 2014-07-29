//
//  EFBColor.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/20/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBColor.h"

@implementation EFBColor

+(UIColor *)efb_silverColor
{
    return [UIColor lightGrayColor];
}

+(UIColor *)efb_blackColor
{
    return [UIColor blackColor];
}

+(UIColor *)efb_bkgColor
{
    return [UIColor colorWithRed:(201.0 / 255.0) green:(231.0/255.0) blue:(239.0/255.0) alpha:1.0];
}

+(UIColor *)efb_cellBkgColor
{
    return [UIColor colorWithRed:(229.0 / 255.0) green:(231.0/255.0) blue:(239.0/255.0) alpha:1.0];
}

+(UIColor *)efb_grassBkgColor
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg"]];
}

@end
