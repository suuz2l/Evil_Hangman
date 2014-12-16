//
//  ViewController.m
//  Hangman
//
//  Created by Suzanne van der Tweel on 14/11/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableDictionary *sortedWords;
    NSMutableArray *possibleWords;
    NSMutableArray *alfabet;
    NSMutableArray *equivalenceClass;
    NSString *letter;
    NSMutableArray * tempArrayWithLetter;
    NSMutableArray * tempArrayWithoutLetter;
    NSMutableArray * tempArray;
    NSArray *words;
    NSMutableArray * wordLabel;
    NSMutableArray * bestWordLabel;
}
@end

@implementation ViewController
@synthesize textField = textField;
@synthesize letterLabel = letterLabel;

- (IBAction)gameButton:(id)sender {
    [self newGame];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self newGame];
}


- (void)wordList {
    // create an array of all the words in the plist file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    words = [[NSArray alloc] initWithContentsOfFile:path];
    
}

-(void) userDefaults{
    //give the standard user default a value when first opening the app
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //set the numLetters value
    int numLetters = (int)[defaults integerForKey:@"numLetters"];
    self.numLetters = numLetters;
    
    if(numLetters== 0){
        [defaults setInteger:7 forKey:@"numLetters"];
    }
    numLetters = [defaults integerForKey:@"numLetters"];
    self.numLetters = numLetters;
    
    //set the numguesses value
    int numGuesses = (int)[defaults integerForKey:@"numGuesses"];
    
    if(numGuesses== 0){
        [defaults setInteger:14 forKey:@"numGuesses"];
    }
    numGuesses = [defaults integerForKey:@"numGuesses"];
    
    self.numGuesses = numGuesses;
}

- (void)newGame {
    self.textField.hidden = YES;
    [self.textField becomeFirstResponder];

    //load wordlist
    [self wordList];

    [self userDefaults];
    
    
    //update the length of the string with the number of letters
    wordLabel = [[NSMutableArray alloc] init];
    for (int i = 1; i <= self.numLetters; i++) {
        [wordLabel addObject:@"_"];
    }
    NSString * word = [wordLabel componentsJoinedByString:@" "];
    
    // show the word and guesses label
    self.wordLabel.text = word;
    self.guessesLabel.text = [NSString stringWithFormat:@"%lu Guesses left", (unsigned long)self.numGuesses];
    
    // create alfabet for the available letters left
    alfabet = [NSMutableArray arrayWithObjects:@"A", @"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    //create possible wordlist according to the length of the words
    possibleWords = [[NSMutableArray alloc] init];
    
    for (NSString *word in words) {
        if ((int)[word length] == self.numLetters){
            [possibleWords addObject:word];
        }
    }
    //NSLog(@"%@", possibleWords);
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:letter
{
    // convert string into uppercase letter and remove the used letter from alfabet
    //[self game:letter];
    NSString * upperLetter = [letter uppercaseString];
    
    //check if the letter is valid
    if (!([alfabet containsObject:upperLetter])) {
        
        // moet guesses wel omlaag??
        NSLog(@"Invalid character or letter is already chosen");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nope!"
                                                        message:@"Invalid character or letter is already chosen"
                                                       delegate:self
                                              cancelButtonTitle:@"Try again"
                                              otherButtonTitles:nil];
        [alert setTag:1];
        [alert show];
    }
    else{
        [alfabet removeObject:upperLetter];
        NSString * alfabetWithSpace = [alfabet componentsJoinedByString:@" "];
        
        self.alfabetLabel.text = alfabetWithSpace;
        
        NSLog(@"%@", letter);
        
        NSMutableDictionary *convertWords = [[NSMutableDictionary alloc] init];
        
        //create a dictionary with the place of letter as key
        for (NSString *word in possibleWords){
            bestWordLabel = [[NSMutableArray alloc] init];
            
            for(int index = 0; index < [word length]; index++){
                char character = [word characterAtIndex:index];
                NSString *s = [NSString stringWithFormat:@"%c", character];
                
                if([s isEqualToString:upperLetter]){
                    [bestWordLabel addObject:[NSString stringWithFormat:@"%@",s]];
                }
                else{
                    [bestWordLabel addObject:@"_"];
                }
            }
            
            // add the converted strings into the dictionary
            if ([convertWords objectForKey:bestWordLabel]){
                // add word to dictionary with the converted string as key
                [[convertWords objectForKey:bestWordLabel] addObject:word];
            }
            else{
                // add new array to dictionary for different converted string as key
                NSMutableArray *wordArray = [[NSMutableArray alloc] initWithObjects:word, nil];
                [convertWords setObject:wordArray forKey:bestWordLabel];
            }
        }
        
        //NSLog(@"Dict with converted words%@", convertWords);
        
        //find the largest array of words
        NSMutableArray *bestKey;
        NSInteger lengthArray = 0;
        for (id key in convertWords) {
            if ((NSInteger) [[convertWords objectForKey:key] count] > lengthArray){
                lengthArray = [[convertWords objectForKey:key] count];
                possibleWords = [convertWords objectForKey:key];
                bestKey = key;
            }
        }
        
        NSString * key = [bestKey componentsJoinedByString:@" "];
        NSLog(@"key %@", key);
        
        // update the wordlabel if the guessed letter is good
        for(int index = 0; index < [bestKey count]; index++){
            letter = [bestKey objectAtIndex:index];
            if (!([letter isEqualToString:@"_"])){
                [wordLabel replaceObjectAtIndex:(index) withObject:letter];
            }
        }
        
        // update the wordlabel with the guessed letter
        NSString * shownWord = [wordLabel componentsJoinedByString:@" "];
        self.wordLabel.text = shownWord;
        
        if (!([shownWord containsString:upperLetter])) {
            self.numGuesses --;
        }
        
        self.guessesLabel.text = [NSString stringWithFormat:@"%lu Guesses left", (unsigned long)self.numGuesses];
        
        if (!([shownWord containsString:@"_"])) {
            NSString *word = [NSString stringWithFormat:@"The word was %@", [possibleWords objectAtIndex:0]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You win!"
                                                            message:word
                                                           delegate:self
                                                  cancelButtonTitle:@"Restart"
                                                  otherButtonTitles:nil];
            
            [alert show];
            [self newGame];
        }
        
        if(self.numGuesses == 0){
            
            NSString *word = [NSString stringWithFormat:@"The word was %@", [possibleWords objectAtIndex:0]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game over!"
                                                            message:word
                                                           delegate:self
                                                  cancelButtonTitle:@"Restart"
                                                  otherButtonTitles:nil];
            
            [alert show];
            [self newGame];
        }
    }
    //NSLog(@"Possiblewords%@", possibleWords);
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


