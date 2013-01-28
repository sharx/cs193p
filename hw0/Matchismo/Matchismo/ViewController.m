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

@interface ViewController ()

@property (nonatomic) PlayingCardDeck *myDeck;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@end

@implementation ViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
  
    //  If we need a deck make one
    if (!self.myDeck) {
        self.myDeck = [[PlayingCardDeck alloc]init];
    }
    
    //  If the card is already showing a suit, just flip it back over
    if (sender.selected) {
        sender.selected = !sender.isSelected;
        self.flipCount++;
        
    } else {
    
        //  Otherwise get a new card from the deck and show it
        PlayingCard *myCard = (PlayingCard *)[self.myDeck drawRandomCard];
    
        if (myCard) {
            [sender setTitle:[myCard contents] forState:UIControlStateSelected];
            sender.selected = !sender.isSelected;
            self.flipCount++;
        
        } else {
        
            //  Oh noes! Out of cards!
            UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"All out of cards!"
                                                              message:nil
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                                    otherButtonTitles:@"Deal again!", nil];
        
            [myAlert show];
        
            //  nil the deck and set the flipCount to 0
            self.myDeck = nil;
            [self setFlipCount:0];
    }
    }

}


@end
