//
//  PlayingCard.h
//  Matchismo
//
//  Created by macshome on 1/26/13.
//  Copyright (c) 2013 macshome. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
