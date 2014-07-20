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

- (instancetype)initWithDelegate:(id<EFBDataServiceDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        self.webSocket = [[EFBWebsocketDriver alloc] initWithURL:[NSURL URLWithString:EFBAPIURL] delegate:self];
    }
    return self;
}

- (void)updateScore:(NSUInteger)score forTeamType:(EFBTeamType)type
{
    NSDictionary *payload = @{@"team" : @(type),
                              @"score" : @(score)
                              };
    [self.webSocket sendPayload:payload];
}

#pragma mark - socket delegate

- (void)socketDriver:(EFBWebsocketDriver *)socketDriver didReceiveData:(NSData *)data
{
    NSError *error;
    NSDictionary *gameDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    EFBGame *game = [EFBGame gameWithDictionary:gameDict];
    
    if (!error && game && [self.delegate respondsToSelector:@selector(dataService:didReceiveUpdatedGame:)]) {
        [self.delegate dataService:self didReceiveUpdatedGame:game];
    }

}

@end
