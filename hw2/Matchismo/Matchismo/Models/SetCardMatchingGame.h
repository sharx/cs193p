//
//  SetCardMatchingGame.h
//  Matchismo
//
//  Created by Josh Wisenbaker on 2/10/13.
//  Copyright (c) 2013 Josh Wisenbaker. All rights reserved.
//

#import "ThreeCardMatchingGame.h"
#import "SetCardDeck.h"

@interface SetCardMatchingGame : ThreeCardMatchingGame


- (SetCard *)cardAtIndex:(NSUInteger)index;

@end
