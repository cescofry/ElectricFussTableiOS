//
//  ElectricFussballAppTests.m
//  ElectricFussballAppTests
//
//  Created by Francesco Frison on 19/07/2014.
//  Copyright (c) 2014 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EFBGame.h"
#import "EFBDataService.h"

@interface ElectricFussballAppTests : XCTestCase

@property (nonatomic, strong) EFBGame *game;

@end

@implementation ElectricFussballAppTests

- (void)setUp {
    [super setUp];
    self.game = [EFBGame gameWithDictionary:[EFBObject mockGameDictionary]];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testHasTeams {
    // This is an example of a functional test case.
    XCTAssertNotNil(self.game.silverTeam, @"Missing Team");
    XCTAssertNotNil(self.game.blackTeam, @"Missing Team");
}

- (void)testTeamsHasPlayers {
    // This is an example of a functional test case.
    XCTAssertNotNil(self.game.silverTeam.players, @"Missing Players");
    XCTAssertTrue(self.game.silverTeam.players.count == 2, @"Wroing number of polayers");
}


@end
