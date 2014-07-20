//
//  EFBGame.m
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import "EFBGame.h"

@implementation EFBUser

+ (instancetype)userWithDictionary:(NSDictionary *)dictionary
{
    if (!dictionary) return nil;
    
    EFBUser *user = [[EFBUser alloc] init];
    user.fullName = dictionary[@"full_name"];
    NSString *urlString = dictionary[@"mugshot_url"];
    user.mugshotURL = [NSURL URLWithString:urlString];
    
    return user;
}

@end


@implementation EFBTeam

+ (EFBTeamType)teamTypeFromName:(NSString *)teamType
{
    return ([teamType isEqualToString:@"red"])? EFBTeamTypeRed : EFBTeamTypeBlue;
}

+ (instancetype)teamWithDictionary:(NSDictionary *)dictionary
{
    EFBTeam *team = [[EFBTeam alloc] init];
    team.user1 = [EFBUser userWithDictionary:dictionary[@"user_1"]];
    team.user2 = [EFBUser userWithDictionary:dictionary[@"user_2"]];
    team.currentScore = [dictionary[@"score"] integerValue];
    team.type = [self teamTypeFromName:dictionary[@"type"]];
    
    return team;
}

@end

@implementation EFBGame

+ (instancetype)gameWithDictionary:(NSDictionary *)dictionary
{
    NSInteger gameID = [dictionary[@"id"] integerValue];
    
    if (gameID == 0) {
        return nil;
    }
    
    EFBGame *game = [[EFBGame alloc] init];
    game.gameID = gameID;
    EFBTeam *team1 = [EFBTeam teamWithDictionary:dictionary[@"team_1"]];
    EFBTeam *team2 = [EFBTeam teamWithDictionary:dictionary[@"team_2"]];
    game.redTeam = (team1.type == EFBTeamTypeRed)? team1 : team2;
    game.blueTeam = (team1.type == EFBTeamTypeBlue)? team1 : team2;
    game.finalScore = [dictionary[@"final_score"] integerValue];
    
    return game;
}

+ (NSDictionary *)mockGameDictionary
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
                               @"id" : @(1),
                               @"final_score" : @(10),
                               @"team_1" : @{
                                       @"user_1" : @{
                                               @"full_name" : @"Francesco Frison",
                                               @"mugshot_url" : @"https://mug0.assets-yammer.com/mugshot/images/DbGKPzNWP5ST9xhW5R4Skxr-0H680t3c"
                                               },
                                       @"user_2" : @{
                                               @"full_name" : @"Mario Caropreso",
                                               @"mugshot_url" : @"https://mug0.assets-yammer.com/mugshot/images/Rhd3G9PsQHZbl1mcDZqqqKQpsx50f7V9"
                                               },
                                       @"score" : @(redScore),
                                       @"type" : @"red"
                                       },
                               @"team_2" : @{
                                       @"user_1" : @{
                                               @"full_name" : @"Ray Brooks",
                                               @"mugshot_url" : @""
                                               },
                                       @"user_2" : @{
                                               @"full_name" : @"Nick Campbell",
                                               @"mugshot_url" : @"https://mug0.assets-yammer.com/mugshot/images/DkvCd1WQQXk3Q32qGk7F-nhQc3w6Shjl"
                                               },
                                       @"score" : @(blueScore),
                                       @"type" : @"blue"
                                       }
                               };
    return gameDict;
}

@end
