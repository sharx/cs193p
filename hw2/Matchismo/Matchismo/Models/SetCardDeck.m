//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Josh Wisenbaker on 2/11/13.
//  Copyright (c) 2013 Josh Wisenbaker. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

//  Make a deck that has one of every possible combination number, symbol, color, and shading
- (id)init {
    self = [super init];
    if (self) {
        for (int i=1; i<=3; i++){
            for (id symbol in [[SetCard class] validSymbols]) {
                for (id color in [[SetCard class] validColors]) {
                    for (id shading in [[SetCard class] validShadings]) {
                    
                        SetCard *card = [[SetCard alloc] init];
                        card.number = i;
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        [self addCard:card atTop:YES];
                    }
               
                }
            }
        }
    }
    return self;
}

@end
