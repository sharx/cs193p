//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Josh Wisenbaker on 2/10/13.
//  Copyright (c) 2013 Josh Wisenbaker. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@property (nonatomic) SetCardMatchingGame *game;
@property (nonatomic) NSInteger flipCount;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic) NSAttributedString *cardContents;


@end


@implementation SetGameViewController

//  If we need a game make one
- (SetCardMatchingGame *)game {
    if (!_game) {
        _game = [[SetCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[SetCardDeck alloc] init]];
    }
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    
    
    //  Cycle through the model and get each card
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        
        //  Set the title to the contents
        [cardButton setAttributedTitle:[self formatCard:card] forState:UIControlStateNormal];
        [cardButton setAttributedTitle:[self formatCard:card] forState:UIControlStateSelected];
        [cardButton setAttributedTitle:[self formatCard:card] forState:UIControlStateSelected|UIControlStateDisabled];
        
        //  Select only if it's faceup
        cardButton.selected = card.isFaceUp;
        
        //  Make it untappable if isUnplayable
        cardButton.enabled = !card.isUnplayable;
        
        //  dissapear unplayable cards 
        cardButton.hidden = card.isUnplayable ? YES : NO;
        
        
    }
    
    //  Update the score string
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %d", self.game.score];
    
    //  Update the status string
    self.statusLabel.text = self.game.statusString;
    
    
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (NSAttributedString *)formatCard:(SetCard *)card {
    
    UIColor *symbolColor;
    NSMutableAttributedString *cardFormat;
    
    //  How many symbols and format the string
    if (card.number == 2) {
        cardFormat = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@", card.symbol, card.symbol]];
    } else if (card.number == 3) {
         cardFormat = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ %@", card.symbol, card.symbol, card.symbol]];
    } else {
        cardFormat = [[NSMutableAttributedString alloc] initWithString:card.symbol];
    }
    

    //  Get the color and set it
    if ([card.color isEqual: @"red"]) {
        symbolColor = [UIColor redColor];
    } else if ([card.color isEqual: @"green"]) {
        symbolColor = [UIColor greenColor];
    } else {
        symbolColor = [UIColor purpleColor];
    }
    
    //  Get the shading and set it
    if ([card.shading isEqual: @"solid"] ) {
        symbolColor = [symbolColor colorWithAlphaComponent:1];
    } else if ([card.shading isEqual: @"striped"]) {
        symbolColor = [symbolColor colorWithAlphaComponent:.6];
    } else {
        symbolColor = [symbolColor colorWithAlphaComponent:.1];
    }
    
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName : symbolColor};
    
    [cardFormat setAttributes:attributes range: NSMakeRange(0, [cardFormat length])];
    
    
    return cardFormat;

    
}

@end
