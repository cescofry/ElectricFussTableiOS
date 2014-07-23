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
- (void)sendPayload:(id)payload;

@end


@protocol EFBWebsocketDriverDelegate <NSObject>

- (void)socketDriver:(EFBWebsocketDriver *)socketDriver didReceiveData:(id)data;
- (void)socketDriverDidOpen:(EFBWebsocketDriver *)socketDriver;

@end