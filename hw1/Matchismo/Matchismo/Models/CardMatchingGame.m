//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by macshome on 2/4/13.
//  Copyright (c) 2013 macshome. All rights reserved.
//

#import "CardMatchingGame.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@interface CardMatchingGame ()
@property (nonatomic)  NSMutableArray *cards;
@property (nonatomic) int score;
@end

@implementation CardMatchingGame

//  Our getter with lazy instantiation.
- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}


//  Our designated init
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
                
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

//  Get a card at a given index. If there isn't a card pass nil
- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

//  Flip a card over This method contains all the logic in our app.
- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    //  Is the card playable?
    if (!card.isUnplayable) {
        //  Look for a match
        if (!card.isFaceUp) {
            
            //  Enumerate the cards
            for (Card *otherCard in self.cards) {
                
                // If the other card is face up and playable
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    
                    //  If it was a match add to the score
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        
                    } else {
                        
                        //  If it wasn't a match pay the grim price
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    
                    // No match so break out
                    break;
                    
                    }
                }
            
            //  Always spend a point to flip a card
            self.score -= FLIP_COST;
            }
     
        
        }
    
        card.faceUp = !card.isFaceUp;
    }
    
    
@end
