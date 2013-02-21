//
//  ViewController.m
//  Matchismo
//
//  Created by macshome on 1/25/13.
//  Copyright (c) 2013 macshome. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "ThreeCardMatchingGame.h"


#define TWO_CARD_GAME 0
#define THREE_CARD_GAME 1

@interface CardGameViewController ()

@property (nonatomic) CardMatchingGame *game;
@property (nonatomic) NSInteger flipCount;
@property (nonatomic) NSInteger gameType;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeController;

- (IBAction)changeGameType:(id)sender;
- (IBAction)dealCards:(id)sender;

@end

@implementation CardGameViewController

//  If we need a game make one
- (CardMatchingGame *)game {
    if (!_game) {
        if (self.gameType == TWO_CARD_GAME) {
            _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[[PlayingCardDeck alloc] init]];
                     
        } else if (self.gameType == THREE_CARD_GAME) {
            _game = [[ThreeCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[[PlayingCardDeck alloc] init]];
        }
    }
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    
    //  Cycle through the model and get each card
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //  Set the card backs for face down cards
        if (!card.isFaceUp) {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
       
        
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
    
    //  Update the status string
    self.statusLabel.text = self.game.statusString;
    
  
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

#pragma mark - IBActions
- (IBAction)flipCard:(UIButton *)sender {
    
    //  Set the game type controller to inactive
    self.gameTypeController.enabled = NO;
    
    // Let the model flip the cards, we just update the UI to show it
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];

}




- (IBAction)changeGameType:(id)sender {
    self.gameType = self.gameTypeController.selectedSegmentIndex;
    self.game = nil;

}

- (IBAction)dealCards:(id)sender {
    
    //  Set the game type controller to active
    self.gameTypeController.enabled = YES;
    
    //  Tell the user we are starting a new game
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Starting a new game!"
                                                      message:nil
                                                     delegate:nil
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"OK", nil];
    
    [myAlert show];
    
    //  nil the game and reset our statusessess
    self.game = nil;
    [self setFlipCount:0];
    self.statusLabel.text = @"";
    [self updateUI];
}

@end
