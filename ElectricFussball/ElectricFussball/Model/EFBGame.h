//
//  EFBGame.h
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFBUser : NSObject

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSURL *mugshotURL;

+ (instancetype)userWithDictionary:(NSDictionary *)dictionary;

@end

typedef NS_ENUM(NSUInteger, EFBTeamType) {
     EFBTeamTypeBlue,
     EFBTeamTypeRed
};

@interface EFBTeam : NSObject

@property (nonatomic, assign) EFBTeamType type;
@property (nonatomic, assign) NSUInteger currentScore;
@property (nonatomic, strong) EFBUser *user1;
@property (nonatomic, strong) EFBUser *user2;

+ (instancetype)teamWithDictionary:(NSDictionary *)dictionary;

@end

@interface EFBGame : NSObject

@property (nonatomic, assign) NSInteger gameID;
@property (nonatomic, assign) NSUInteger finalScore;
@property (nonatomic, strong) EFBTeam *team1;
@property (nonatomic, strong) EFBTeam *team2;

+ (instancetype)gameWithDictionary:(NSDictionary *)dictionary;

+ (NSDictionary *)mockGameDictionary;

@end
