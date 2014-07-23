//
//  EFBGame.h
//  ElectricFussball
//
//  Created by Francesco Frison on 7/18/14.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EFBPayloadProtocol <NSObject>

- (NSDictionary *)payload;

@end

@interface EFBPlayer : NSObject <EFBPayloadProtocol>

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSURL *mugshotURL;
@property (nonatomic, strong) NSString *rfid;
@property (nonatomic, strong) NSString *alias;

+ (instancetype)playerWithDictionary:(NSDictionary *)dictionary;


@end

typedef NS_ENUM(NSUInteger, EFBTeamType) {
     EFBTeamTypeSilver,
     EFBTeamTypeBlack
};

@interface EFBTeam : NSObject <EFBPayloadProtocol>

@property (nonatomic, assign) EFBTeamType type;
@property (nonatomic, assign) NSUInteger currentScore;
@property (nonatomic, strong) NSArray *players;

+ (instancetype)teamWithDictionary:(NSDictionary *)dictionary;

@end

@interface EFBGame : NSObject <EFBPayloadProtocol>

@property (nonatomic, strong) NSUUID *gameID;
@property (nonatomic, assign) NSUInteger finalScore;
@property (nonatomic, strong) EFBTeam *silverTeam;
@property (nonatomic, strong) EFBTeam *blackTeam;

+ (instancetype)gameWithDictionary:(NSDictionary *)dictionary;

@end

@interface EFBObject : NSObject

+ (id)objectFromDictionary:(NSDictionary *)dictionary;

#pragma mark - Mocking
+ (NSDictionary *)mockGameDictionary;
+ (NSDictionary *)mockUnknownPlayer;
+ (NSDictionary *)mockPlayer;

@end
