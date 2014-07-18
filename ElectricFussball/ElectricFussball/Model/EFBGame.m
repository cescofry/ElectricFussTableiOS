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
    user.mugshotURL = dictionary[@"mugshot_url"];
    
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
    EFBGame *game = [[EFBGame alloc] init];
    game.gameID = dictionary[@"id"];
    game.team1 = [EFBTeam teamWithDictionary:dictionary[@"team_1"]];
    game.team2 = [EFBTeam teamWithDictionary:dictionary[@"team_2"]];
    game.finalScore = [dictionary[@"final_score"] integerValue];
    
    return game;
}

@end
