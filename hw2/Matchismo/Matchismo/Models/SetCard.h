//
//  SetCard.h
//  Matchismo
//
//  Created by Josh Wisenbaker on 2/10/13.
//  Copyright (c) 2013 Josh Wisenbaker. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSString *symbol;
@property (nonatomic) NSString *shading;
@property (nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
