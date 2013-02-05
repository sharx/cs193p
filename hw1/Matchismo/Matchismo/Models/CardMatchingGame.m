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

#define TWO_CARD_GAME 0
#define THREE_CARD_GAME 1

//  I decided to put the status messages in the model. This is the class that knows about the data,
//  that has the data, and is responsible for the score. This made it easy to just format the
//  strings here. The ViewController can simply call the getter for the status message.

//  I used defines for the status message formatting as it made the code more readable below.
#define FLIP_MESSAGE @"Flipped up %@", card.contents
#define TWO_MATCH_MESSAGE @"Matched %@ & %@ for %d points!", card.contents, otherCard.contents, (matchScore * MATCH_BONUS)
#define NO_TWO_MATCH_MESSAGE @"%@ & %@ don't match! -%d points!", card.contents, otherCard.contents, MISMATCH_PENALTY
#define THREE_MATCH_MESSAGE @"%@ & %@ & %@ for %d points!", card.contents, firstCard.contents, secondCard.contents, (matchScore * MATCH_BONUS)
#define NO_THREE_MATCH_MESSAGE @"%@ & %@ & %@ don't match!", card.contents, firstCard.contents, secondCard.contents

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
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck gameType:(NSInteger)gameType {
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
    
    self.gameType = gameType;
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
            
            //  Determine if we are matching 2 or 3 cards
            if (self.gameType  == TWO_CARD_GAME) {
                
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
            } else if (self.gameType == THREE_CARD_GAME) {
                    
                    //  Let the user know they flipped a card
                    self.statusString = [NSString stringWithFormat:FLIP_MESSAGE];
                    
                    //  Make an array to store our cards
                    NSMutableArray *otherCards = [NSMutableArray array];
                    
                    //  Enumerate the cards
                    for (Card *otherCard in self.cards) {
                        
                        // If the other card is face up and playable
                        if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                            [otherCards addObject:otherCard];
                        }
                    }
                    
                        if ([otherCards count] == 2) {
                            //  Get the cards and look for a match
                            Card *firstCard = [otherCards objectAtIndex:0];
                            Card *secondCard = [otherCards lastObject];
                            
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
                        
            }
    
    //  Always spend a point to flip a card
    self.score -= FLIP_COST;
    
    card.faceUp = !card.isFaceUp;
    
}
    

    
    

    



@end
