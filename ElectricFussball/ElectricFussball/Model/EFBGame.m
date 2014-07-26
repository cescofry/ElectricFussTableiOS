//
//  EFBGame.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBGame.h"

@implementation EFBPlayer

+ (instancetype)playerWithDictionary:(NSDictionary *)dictionary
{
    NSString *type = dictionary[@"type"];
    NSAssert([type isEqualToString:@"player"], @"Wrong payload for object type");
    
    EFBPlayer *player = [[EFBPlayer alloc] init];
    player.fullName = dictionary[@"name"];
    NSString *urlString = dictionary[@"mugshot"];
    player.mugshotURL = [NSURL URLWithString:urlString];
    player.rfid = dictionary[@"signature"];
    player.alias = dictionary[@"permalink"];
    
    return player;
}

- (NSDictionary *)payload
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.fullName) dict[@"name"] = self.fullName;
    if (self.mugshotURL) dict[@"mugshot"] = [self.mugshotURL absoluteString];
    if (self.rfid) dict[@"signature"] = self.rfid;
    if (self.alias) dict[@"alias"] = self.alias;
    
    dict[@"timestamp"] = @([[NSDate date] timeIntervalSince1970]);
    
    return [dict copy];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[EFBPlayer class]]) {
        return NO;
    }
    
    EFBPlayer *player = (EFBPlayer *)object;
    if (self.rfid.length > 0 && player.rfid.length > 0) {
        return [self.rfid isEqualToString:player.rfid];
    }
    else if (self.alias.length > 0 && player.alias.length > 0) {
        return [self.alias isEqualToString:player.alias];
    }
    
    return NO;
}

@end


@implementation EFBTeam

+ (EFBTeamType)teamTypeFromName:(NSString *)teamType
{
    return ([teamType isEqualToString:@"silver"])? EFBTeamTypeSilver : EFBTeamTypeBlack;
}

- (NSString *)teamTypeName
{
    return (self.type == EFBTeamTypeSilver)? @"silver" : @"black";
}

+ (instancetype)teamWithDictionary:(NSDictionary *)dictionary
{
    
    NSString *type = dictionary[@"type"];
    NSAssert([type isEqualToString:@"team"], @"Wrong payload for object type");
    
    EFBTeam *team = [[EFBTeam alloc] init];
    NSArray *playersResource = dictionary[@"players"];
    NSMutableArray *players = [NSMutableArray array];
    [playersResource enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [players addObject:[EFBPlayer playerWithDictionary:obj]];
    }];
    team.players = [players copy];
    
    team.currentScore = [dictionary[@"score"] integerValue];
    team.type = [self teamTypeFromName:dictionary[@"color"]];
    
    return team;
}

- (NSDictionary *)payload
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *players = [NSMutableArray array];
    [self.players enumerateObjectsUsingBlock:^(EFBPlayer *obj, NSUInteger idx, BOOL *stop) {
        [players addObject:obj.payload];
    }];
    dict[@"players"] = players;
    dict[@"score"] = @(self.currentScore);
    dict[@"color"] = [self teamTypeName];
    
    dict[@"timestamp"] = @([[NSDate date] timeIntervalSince1970]);
    
    return [dict copy];
}

@end

@implementation EFBGame

+ (instancetype)gameWithDictionary:(NSDictionary *)dictionary
{
    NSString *type = dictionary[@"type"];
    NSString *gameID = dictionary[@"id"];
    
    NSAssert([type isEqualToString:@"game"], @"Wrong payload for object type");
    
    EFBGame *game = [[EFBGame alloc] init];
    game.gameID = [[NSUUID alloc] initWithUUIDString:gameID];
    NSAssert(game.gameID, @"Missing game ID");
    
    NSArray *teams = dictionary[@"teams"];
    [teams enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        EFBTeam *team = [EFBTeam teamWithDictionary:obj];
        if (team.type == EFBTeamTypeSilver) {
            game.silverTeam = team;
        }
        else {
            game.blackTeam = team;
        }
    }];
    
    game.finalScore = [dictionary[@"final_score"] integerValue];
    
    return game;
}

- (NSDictionary *)payload
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"id"] = [self.gameID UUIDString];
    
    NSMutableArray *teams = [NSMutableArray array];
    [teams addObject:[self.silverTeam payload]];
    [teams addObject:[self.blackTeam payload]];
    
    dict[@"final_score"] = @(self.finalScore);
    
    dict[@"timestamp"] = @([[NSDate date] timeIntervalSince1970]);
    
    return [dict copy];
}

@end

@implementation EFBObject

+ (id)objectFromDictionary:(NSDictionary *)dictionary
{
    NSString *type = dictionary[@"type"];
    
    if ([type isEqualToString:@"game"]) {
        return [EFBGame gameWithDictionary:dictionary];
    }
    else if ([type isEqualToString:@"team"]) {
        return [EFBTeam teamWithDictionary:dictionary];
    }
    else if ([type isEqualToString:@"player"]) {
        return [EFBPlayer playerWithDictionary:dictionary];
    }
    
    return nil;
}

#pragma mark - Mocking -

+ (NSDictionary *)mockFullGameDictionary
{
    
    static NSUInteger redScore = 0;
    static NSUInteger blueScore = 0;
    
    if (arc4random()%2 == 0) {
        redScore++;
    }
    else {
        blueScore++;
    }
    
    NSDictionary *gameDict = @{
                               @"type" : @"game",
                               @"id" : @"E621E1F8-C36C-495A-93FC-0C247A3E6E5F",
                               @"final_score" : @(10),
                               @"teams" :@[@{
                                               @"type" : @"team",
                                               @"players" : @[@{
                                                                  @"type" : @"player",
                                                                  @"name" : @"Francesco Frison",
                                                                  @"mugshot" : @"https://mug0.assets-yammer.com/mugshot/images/DbGKPzNWP5ST9xhW5R4Skxr-0H680t3c"
                                                                  },
                                                              @{
                                                                  @"type" : @"player",
                                                                  @"name" : @"Mario Caropreso",
                                                                  @"mugshot" : @"https://mug0.assets-yammer.com/mugshot/images/Rhd3G9PsQHZbl1mcDZqqqKQpsx50f7V9"
                                                                  }],
                                               @"score" : @(redScore),
                                               @"color" : @"silver"
                                               },
                                           @{
                                               @"type" : @"team",
                                               @"players" : @[@{
                                                                  @"type" : @"player",
                                                                  @"name" : @"Ray Brooks",
                                                                  @"mugshot" : @""
                                                                  },
                                                              @{
                                                                  @"type" : @"player",
                                                                  @"name" : @"Nick Campbell",
                                                                  @"mugshot" : @"https://mug0.assets-yammer.com/mugshot/images/DkvCd1WQQXk3Q32qGk7F-nhQc3w6Shjl"
                                                                  }],
                                               @"score" : @(blueScore),
                                               @"color" : @"black"
                                               }
                                           ]
                               };
    return gameDict;
}

+ (NSDictionary *)mock2PGameDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self mockFullGameDictionary]];
    NSArray *teams = dict[@"teams"];
    NSMutableDictionary *team1 = [NSMutableDictionary dictionaryWithDictionary:[teams firstObject]];
    team1[@"players"] = @[[team1[@"players"] firstObject]];
    
    NSMutableDictionary *team2 = [NSMutableDictionary dictionaryWithDictionary:[teams lastObject]];
    team2[@"players"] = @[[team2[@"players"] firstObject]];
    
    dict[@"teams"] = @[team1, team2];
    
    return dict;
}

+ (NSDictionary *)mockUnknownPlayer
{
    return @{
             @"type" : @"player",
             @"signature" : @"23j3d8j2m3dj823jd"
             };
}

+ (NSDictionary *)mockPlayer
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self mockUnknownPlayer]];
    dict[@"permalink"] = @"ffrison";
    dict[@"name"] = @"Francesco Frison";
    return [dict copy];
}

@end
