//
//  ViewController.m
//  Matchismo
//
//  Created by macshome on 1/25/13.
//  Copyright (c) 2013 macshome. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

//  If we need a game make one
- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    //  Cycle through the model and get each card
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //  Set the title to the contents
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        //  Select only if it's faceup
        cardButton.selected = card.isFaceUp;
        
        //  Make it untappable if isUnplayable
        cardButton.enabled = !card.isUnplayable;
        
        //  Dim unplayable cards so they look different
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    
    //  Update the score string
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %d", self.game.score];
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    
    // Let the model flip the cards, we just update the UI to show it
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];

}


@end
