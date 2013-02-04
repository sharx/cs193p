//
//  PlayingCard.m
//  Matchismo
//
//  Created by macshome on 1/26/13.
//  Copyright (c) 2013 macshome. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

#pragma mark - Class methods
+ (NSArray *)validSuits {
    return @[@"♠", @"♣", @"♥", @"♦"];
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return ([[self rankStrings] count]-1);
}


#pragma mark - Override methods
//  Override the match: method from Card

- (int)match:(NSArray *)otherCards {
    //  Set score to 0
    int score = 0;
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards lastObject]; //  The lastObject method means we are never out of bounds!
        
        //  Our scoring algorithm
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
            
    }
    // Return the score
    return score;
}
        
    
    
    








#pragma mark - Instane methods
- (NSString *)contents {
    
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (NSString *)description {
    return [self contents];
}

@end
