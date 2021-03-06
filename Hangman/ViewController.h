//
//  ViewController.h
//  Hangman
//
//  Created by Suzanne van der Tweel on 14/11/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipsideViewController.h"

@interface ViewController : UIViewController 

@property (nonatomic, readwrite, weak) IBOutlet UITextField * textField;
@property (nonatomic, strong) IBOutlet UIButton * settingsButton;
@property (nonatomic, strong) IBOutlet UIButton * gameButton;
@property (nonatomic, strong) IBOutlet UILabel * wordLabel;
@property (nonatomic, strong) IBOutlet UILabel * guessesLabel;
@property (weak, nonatomic) IBOutlet UILabel * letterLabel;
@property (nonatomic, strong) IBOutlet UILabel * alfabetLabel;
@property NSInteger numGuesses;
@property NSInteger numLetters;

@end

