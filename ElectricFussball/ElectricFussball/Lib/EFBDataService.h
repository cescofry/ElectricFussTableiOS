//
//  EFBSocketDriver.h
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFBDataService : NSObject

@property(nonatomic, strong, readonly) NSURL *url;

- (instancetype)initWithURL:(NSURL *)url;

@end
