//
//  Deck.h
//  Matchismo
//
//  Created by macshome on 1/26/13.
//  Copyright (c) 2013 macshome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
