//
//  EFBSocketDriver.h
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EFBWebsocketDriverDelegate;
@interface EFBWebsocketDriver : NSObject

@property(nonatomic, strong, readonly) NSURL *url;
@property(nonatomic, weak, readonly) id<EFBWebsocketDriverDelegate> delegate;

- (instancetype)initWithURL:(NSURL *)url delegate:(id<EFBWebsocketDriverDelegate>)delegate;

@end


@protocol EFBWebsocketDriverDelegate <NSObject>

- (void)socketDriver:(EFBWebsocketDriver *)socketDriver didReceiveData:(NSData *)data;

@end