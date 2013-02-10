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

//  I decided to put the status messages in the model. This is the class that knows about the data,
//  that has the data, and is responsible for the score. This made it easy to just format the
//  strings here. The ViewController can simply call the getter for the status message.

//  I used defines for the status message formatting as it made the code more readable below.
#define FLIP_MESSAGE @"Flipped up %@", card.contents
#define TWO_MATCH_MESSAGE @"Matched %@ & %@ for %d points!", card.contents, otherCard.contents, (matchScore * MATCH_BONUS)
#define NO_TWO_MATCH_MESSAGE @"%@ & %@ don't match! -%d points!", card.contents, otherCard.contents, MISMATCH_PENALTY


@interface CardMatchingGame ()
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSString *statusString;
@property (nonatomic) NSUInteger gameType;
@end

@implementation CardMatchingGame

//  Our getter with lazy instantiation.
- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
   
    return _cards;
}

- (NSString *)statusString {
    if (!_statusString) {
        _statusString = [[NSString alloc] init];
    }
    
    return _statusString;
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
    
    // I put these tests ourside the loops so I only need them once
    
    //  Is the card playable?
    if (card && !card.isUnplayable) {
      
        //  Look for a match
        if (!card.isFaceUp) {
            
          
                
            //  Let the user know they flipped a card
            self.statusString = [NSString stringWithFormat:FLIP_MESSAGE];
            
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
                            
                            //  Tell the user what they matched
                            self.statusString = [NSString stringWithFormat:TWO_MATCH_MESSAGE];
                            
                        } else {
                            
                            //  If it wasn't a match pay the grim price
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            
                            //  Tell the user they didn't match anything
                            self.statusString = [NSString stringWithFormat:NO_TWO_MATCH_MESSAGE];
                        }
                        
                        // No match so break out
                        break;
                        
                        }

                    }
            
                    
                }
                        
            }
    
    //  Always spend a point to flip a card
    self.score -= FLIP_COST;
    
    card.faceUp = !card.isFaceUp;
    
}
    

    
    

    



@end
