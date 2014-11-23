//
//  ViewController.h
//  Hangman
//
//  Created by Suzanne van der Tweel on 14/11/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, readwrite, weak) IBOutlet UITextField * textField;
@property (nonatomic, strong) IBOutlet UIButton * settingsButton;
@property (nonatomic, strong) IBOutlet UIButton * gameButton;
@property (nonatomic, strong) IBOutlet UILabel * wordLabel;
@property (nonatomic, strong) IBOutlet UILabel * guessesLabel;
@property (nonatomic, strong) IBOutlet UISlider * lettersSlider;
@property (nonatomic, strong) IBOutlet UISlider * guessesSlider;
@property (nonatomic, strong) IBOutlet UILabel * numGuessesLabel;
@property (nonatomic, strong) IBOutlet UILabel * numLettersLabel;

@end

