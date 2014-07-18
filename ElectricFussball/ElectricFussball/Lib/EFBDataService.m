//
//  EFBSocketDriver.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBDataService.h"
#import "SRWebSocket.h"

@interface EFBDataService () <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;

@end

@implementation EFBDataService

- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        _url = url;
        self.webSocket = [[SRWebSocket alloc] initWithURL:self.url];
        self.webSocket.delegate = self;
        [self.webSocket open];
        
    }
    return self;
}


- (void)fakeData
{
    static NSInteger count = 0;
    count++;
    
    NSData *data = [[NSString stringWithFormat:@"%ld bottles of beer", count] dataUsingEncoding:NSUTF8StringEncoding];
    [self.webSocket send:data];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((count * 10) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fakeData];
    });
}

#pragma mark - Web Socket Delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"Did open socket at %@", webSocket.url.description);
    
    [self fakeData];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    
    NSString *dataS = [[NSString alloc] initWithData:message encoding:NSUTF8StringEncoding];
    
    NSLog(@">> %@ <<", dataS);
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error.debugDescription);
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"Close with reason: %@", reason);
}

@end
