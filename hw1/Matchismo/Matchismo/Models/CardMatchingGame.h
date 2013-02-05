//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by macshome on 2/4/13.
//  Copyright (c) 2013 macshome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *statusString;

//  Designated init
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck gameType:(NSInteger)gameType;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@end
