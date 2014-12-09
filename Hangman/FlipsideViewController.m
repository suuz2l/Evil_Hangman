//
//  FlipsideViewController.m
//  Hangman
//
//  Created by Suzanne van der Tweel on 24/11/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Load the list of words
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words_short" ofType:@"plist"];
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:path];
    
    // Get the longest/shortest length of all the words
    NSNumber *maxLength= [words valueForKeyPath: @"@max.length"];
    NSNumber *minLength= [words valueForKeyPath: @"@min.length"];
    
    self.lettersSlider.minimumValue = [minLength integerValue];
    self.lettersSlider.maximumValue = [maxLength integerValue];
    self.guessesSlider.minimumValue = 1;
    self.guessesSlider.maximumValue = 26;
   

    //Standard User defaults
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    int numLetters = (int)[defaults integerForKey:@"numLetters"];
    int numGuesses = (int)[defaults integerForKey:@"numGuesses"];
    
    self.guessesSlider.value = numGuesses;
    self.lettersSlider.value = numLetters;
    self.numLettersLabel.text = [NSString stringWithFormat:@"%.0f", ceilf(self.lettersSlider.value)];
    self.numGuessesLabel.text = [NSString stringWithFormat:@"%.0f", ceilf(self.guessesSlider.value)];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SliderValueChanged:(UISlider *)sender {
    int value = (int)ceilf(sender.value);
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:@"numLetters"];
    self.numLettersLabel.text = [NSString stringWithFormat:@"%.0f", self.lettersSlider.value];
    [defaults synchronize];

}

- (IBAction)GuessesSliderValueChanged:(UISlider *)sender {
    int value = (int)ceilf(sender.value);
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:@"numGuesses"];
    self.numGuessesLabel.text = [NSString stringWithFormat:@"%.0f", self.guessesSlider.value];
    [defaults synchronize];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
