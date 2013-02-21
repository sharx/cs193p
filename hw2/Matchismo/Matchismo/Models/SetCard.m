//
//  SetCard.m
//  Matchismo
//
//  Created by Josh Wisenbaker on 2/10/13.
//  Copyright (c) 2013 Josh Wisenbaker. All rights reserved.
//

#import "SetCard.h"

@interface SetCard ()

@end

@implementation SetCard

+ (NSArray *)validSymbols {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validColors {
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validShadings {
    return @[@"solid", @"striped", @"open"];
}


#pragma mark - Override methods
//  Override the match: method from Card

- (int)match:(NSArray *)otherCards {
    
    //  Initilize the score
    int score = 0;
    
    //  Do we have two other cards?
    if ([otherCards count] == 2) {
        SetCard *firstCard = self; //  We are the first card.
        SetCard *secondCard = [otherCards objectAtIndex:0]; //  Get the first object in the other cards
        SetCard *thirdCard = [otherCards lastObject]; //  The lastObject method means we are never out of bounds!
        
        //  Our scoring algorithm. In Set we need to either match all three cards with the same attribute or no attributes
        // Numbers need to all match or all be different
        if ((((firstCard.number == secondCard.number) && (secondCard.number == thirdCard.number) && (firstCard.number == thirdCard.number))
            ||
           ((firstCard.number != secondCard.number) && (secondCard.number != thirdCard.number) && (firstCard.number != thirdCard.number)))
            
            && // Same with symbols. match all or none.
            (((firstCard.symbol == secondCard.symbol) && (secondCard.symbol == thirdCard.symbol) && (firstCard.symbol == thirdCard.symbol))
              ||
              ((firstCard.symbol != secondCard.symbol) && (secondCard.symbol != thirdCard.symbol) && (firstCard.symbol != thirdCard.symbol)))

            && // Same with colors. match all or none.
            (((firstCard.color == secondCard.color) && (secondCard.color == thirdCard.color) && (firstCard.color == thirdCard.color))
             ||
             ((firstCard.color != secondCard.color) && (secondCard.color != thirdCard.color) && (firstCard.color != thirdCard.color)))
            
            && // Same with shading. match all or none.
            (((firstCard.shading == secondCard.shading) && (secondCard.shading == thirdCard.shading) && (firstCard.shading == thirdCard.shading))
             ||
             ((firstCard.shading != secondCard.shading) && (secondCard.shading != thirdCard.shading) && (firstCard.shading != thirdCard.shading)))
            )
        {
            score = 1;
        }
        
    }
    
    // Return the score
    return score;
}

#pragma mark - Instance methods
- (NSString *)contents {
    
    return [NSString stringWithFormat:@"%d-%@-%@-%@", self.number, self.symbol, self.color, self.shading];
}

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}


- (void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)description {
    return [self contents];
}

@end
