//
//  FlipsideViewController.h
//  Hangman
//
//  Created by Suzanne van der Tweel on 24/11/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipsideViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISlider * lettersSlider;
@property (nonatomic, weak) IBOutlet UISlider * guessesSlider;
@property (nonatomic, strong) IBOutlet UILabel * GuessesLabel;
@property (nonatomic, strong) IBOutlet UILabel * LettersLabel;
@property (nonatomic, strong) IBOutlet UILabel * numLettersLabel;
@property (nonatomic, strong) IBOutlet UILabel * numGuessesLabel;

-(IBAction)SliderValueChanged:(UISlider *)sender;
-(IBAction)GuessesSliderValueChanged:(UISlider *)sender;




@end
