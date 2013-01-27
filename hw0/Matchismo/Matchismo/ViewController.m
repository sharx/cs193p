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
  
    if (!self.myDeck) {
        self.myDeck = [[PlayingCardDeck alloc]init];
    }
    
    
    PlayingCard *myCard = (PlayingCard *)[self.myDeck drawRandomCard];
    
    if (myCard) {
        [sender setTitle:[myCard contents] forState:UIControlStateSelected];
        sender.selected = !sender.isSelected;
        self.flipCount++;
    } else {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"All out of cards!"
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"Deal again!", nil];
        
        [myAlert show];
        
        self.myDeck = nil;
        [self setFlipCount:0];
    }
   
}


@end
