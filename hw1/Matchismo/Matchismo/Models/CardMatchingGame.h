//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Josh Wisenbaker on 2/4/13.
//  Copyright (c) 2013 Josh Wisenbaker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) int score;

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@end
