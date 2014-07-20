//
//  EFBSocketDriver.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBWebsocketDriver.h"
#import "SRWebSocket.h"
#import "EFBGame.h"

static const NSInteger maxRetryCount = 5;

@interface EFBWebsocketDriver () <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;
@property (nonatomic, assign) NSInteger retryCount;

@end

@implementation EFBWebsocketDriver

- (instancetype)initWithURL:(NSURL *)url delegate:(id<EFBWebsocketDriverDelegate>)delegate
{
    self = [super init];
    if (self) {
        _url = url;
        _delegate = delegate;
        self.retryCount = 0;
        
        self.webSocket = [[SRWebSocket alloc] initWithURL:self.url];
        self.webSocket.delegate = self;
        
        [self tryConnect];
    }
    return self;
}

- (void)tryConnect
{
    if (self.retryCount < maxRetryCount) {
        [self.webSocket open];
        self.retryCount++;
    }
    else {
        NSLog(@"Fatal. Try to open %ld time without success", self.retryCount);
    }
}

- (void)sendPayload:(id)payload
{
    NSData *data = nil;
    NSError *error;
    if ([payload isKindOfClass:[NSData class]]) {
        data = payload;
    }
    else if ([payload isKindOfClass:[NSDictionary class]] || [payload isKindOfClass:[NSArray class]]) {
        data = [NSJSONSerialization dataWithJSONObject:payload options:NSJSONWritingPrettyPrinted error:&error];
    }
    else if ([payload isKindOfClass:[NSString class]]) {
        data = [(NSString *)payload dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (!data || error) {
        NSLog(@"Problem converting paylod for class [%@] %@", NSStringFromClass([payload class]), error);
    }
    else {
        [self.webSocket send:data];
    }
}

- (void)fakeData
{

    [self sendPayload:[EFBGame mockGameDictionary]];
    NSInteger time = arc4random()%5 + 60;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fakeData];
    });
}

#pragma mark - Web Socket Delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"Did open socket at %@", webSocket.url.description);
    self.retryCount = 0;
    [self fakeData];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    if (message && [self.delegate respondsToSelector:@selector(socketDriver:didReceiveData:)]) {
        [self.delegate socketDriver:self didReceiveData:message];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    [self tryConnect];
    NSLog(@"Error: %@", error.debugDescription);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    [self tryConnect];
    NSLog(@"Close with reason: %@", reason);
}

@end
