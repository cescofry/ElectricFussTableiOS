//
//  EFBDataService.m
//  ElectricFussball
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBDataService.h"
#import "EFBWebsocketDriver.h"
#import "EFBAPICostants.h"

@interface EFBDataService () <EFBWebsocketDriverDelegate>

@property (nonatomic, strong) EFBWebsocketDriver *webSocket;

@end

@implementation EFBDataService

- (instancetype)initWithDelegate:(id<
                                  EFBDataServiceDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@:%ld/", EFBBaseURL, EFBSocketPort]];
        self.webSocket = [[EFBWebsocketDriver alloc] initWithURL:url delegate:self];
        
    }
    return self;
}

- (void)enqueRequestToPath:(NSString *)path withPayload:(id)payload
{
    
    if ([payload isKindOfClass:[NSDictionary class]] || [payload isKindOfClass:[NSArray class]]) {
        payload = [NSJSONSerialization dataWithJSONObject:payload options:0 error:NULL];
    }
    else if ([payload isKindOfClass:[NSString class]]) {
        payload = [(NSString *)payload dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURL *url = [NSURL URLWithString:[EFBBaseURL stringByAppendingPathComponent:path]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setTimeoutInterval:5];
    [req setCachePolicy:NSURLCacheStorageNotAllowed];
    [req setHTTPBody:payload];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Connection Error: %@", connectionError.description);
        }
    }];
}

- (void)updateTeam:(EFBTeam *)team onGameID:(NSUUID *)uuid
{
    NSString *path = [NSString stringWithFormat:EFBUpdateGamePath_, [uuid UUIDString]];
    [self enqueRequestToPath:path withPayload:team.payload];
}

 -(void)updatePlayer:(EFBPlayer *)player
{
    [self enqueRequestToPath:EFBUpdatePlayerPath withPayload:[player payload]];
}

#pragma mark - socket delegate

- (void)socketDriver:(EFBWebsocketDriver *)socketDriver didReceiveData:(id)data
{
    NSError *error;
    
    if ([data isKindOfClass:[NSString class]]) {
        data = [(NSString *)data dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSDictionary *objDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    id object = [EFBObject objectFromDictionary:objDict];
    
    if ([object isKindOfClass:[EFBGame class]] && [self.delegate respondsToSelector:@selector(dataService:didReceiveUpdatedGame:)]) {
        [self.delegate dataService:self didReceiveUpdatedGame:object];
    }
    else if ([object isKindOfClass:[EFBPlayer class]] && [self.delegate respondsToSelector:@selector(dataService:didReceiveUpdatedPlayer:)]) {
        [self.delegate dataService:self didReceiveUpdatedPlayer:object];
    }

}

@end
