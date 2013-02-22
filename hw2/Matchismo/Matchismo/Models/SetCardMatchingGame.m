//
//  SetCardMatchingGame.m
//  Matchismo
//
//  Created by Josh Wisenbaker on 2/10/13.
//  Copyright (c) 2013 Josh Wisenbaker. All rights reserved.
//

#import "SetCardMatchingGame.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

//  I used defines for the status message formatting as it made the code more readable below.
#define FLIP_MESSAGE @"Selected %@", card.contents
#define THREE_MATCH_MESSAGE @"Match for %d points!",  (matchScore * MATCH_BONUS)
#define NO_THREE_MATCH_MESSAGE @"That's not a set!"

@interface CardMatchingGame ()
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSString *statusString;
@end

@implementation SetCardMatchingGame

//  Get a card at a given index. If there isn't a card pass nil
- (SetCard *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

//  Override the default two card flip method
- (void)flipCardAtIndex:(NSUInteger)index {
    
    SetCard *card = [self cardAtIndex:index];
    
    // I put these tests ourside the loops so I only need them once
    
    //  Is the card playable?
    if (card && !card.isUnplayable) {
        
        //  Look for a match
        if (!card.isFaceUp) {
            
            //  Let the user know they flipped a card
            self.statusString = [NSString stringWithFormat:FLIP_MESSAGE];
            
            //  Make an array to store our cards
            NSMutableArray *otherCards = [NSMutableArray array];
            
            //  Enumerate the cards
            for (SetCard *otherCard in self.cards) {
                
                // If the other card is face up and playable
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                }
            }
            
            if ([otherCards count] == 2) {
                //  Get the cards and look for a match
                SetCard *firstCard = [otherCards objectAtIndex:0];
                SetCard *secondCard = [otherCards lastObject];
                
                int matchScore = [card match:(NSArray *)otherCards];
                
                
                
                //  If it was a match add to the score
                if (matchScore) {
                    
                    //  Take the cards out of play
                    firstCard.unplayable = YES;
                    secondCard.unplayable = YES;
                    card.unplayable = YES;
                    
                    self.score += matchScore * MATCH_BONUS;
                    
                    //  Tell the user what they matched
                    self.statusString = [NSString stringWithFormat:THREE_MATCH_MESSAGE];
                    
                } else {
                    
                    //  If it wasn't a match pay the grim price
                    firstCard.faceUp = NO;
                    secondCard.faceUp = NO;
                    card.faceUp = YES;
                    
                    self.score -= MISMATCH_PENALTY;
                    
                    //  Tell the user they didn't match anything
                    self.statusString = [NSString stringWithFormat:NO_THREE_MATCH_MESSAGE];
                    
                }
                
            }
        }
        
    }
    
    
    
    //  Always spend a point to flip a card
    self.score -= FLIP_COST;
    
    card.faceUp = !card.isFaceUp;
    
}


@end
