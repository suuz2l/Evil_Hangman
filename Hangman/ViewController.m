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



- (void)viewDidLoad {
   
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // hide the texfield and put the keyboard up as standard
    self.textField.hidden = YES;
    [self.textField becomeFirstResponder];
    
    [self wordList];
    
    //give the standard user default a value when first opening the app
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //set the numLetters value
    NSUInteger numLetters = [defaults integerForKey:@"numLetters"];
    if(numLetters== 0){
        [defaults setInteger:7 forKey:@"numLetters"];
    }
    numLetters = [defaults integerForKey:@"numLetters"];
    
    //set the numGuesses value
    NSUInteger numGuesses = [defaults integerForKey:@"numGuesses"];
    if(numGuesses== 0){
        [defaults setInteger:14 forKey:@"numGuesses"];
    }
    numGuesses = [defaults integerForKey:@"numGuesses"];
    
    wordLabel = [[NSMutableArray alloc] init];
    //update the length of the string with the number of letters
    for (int i = 1; i <= numLetters; i++) {
        [wordLabel addObject:@"_"];
    }
    NSString * word = [wordLabel componentsJoinedByString:@" "];
    
    // show the word and guesses label
    self.wordLabel.text = word;
    self.guessesLabel.text = [NSString stringWithFormat:@"%lu Guesses left", (unsigned long)numGuesses];
    
    // create alfabet for the available letters left
    alfabet = [NSMutableArray arrayWithObjects:@"A", @"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
    //create possible wordlist according to the length of the words
    possibleWords = [[NSMutableArray alloc] init];

    for (NSString *word in words) {
        if ((int)[word length] == numLetters){
            [possibleWords addObject:word];
        }
    }
    NSLog(@"%@", possibleWords);
}


- (void)wordList {
    // create an array of all the words in the plist file
    // [self wordlist]
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words_short" ofType:@"plist"];
    words = [[NSArray alloc] initWithContentsOfFile:path];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:letter
    {
        NSLog(@"TEST");
    // convert string into uppercase letter and remove the used letter from alfabet
    NSString * upperLetter = [letter uppercaseString];
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
//                [tempWord appendString:[NSString stringWithFormat:@"%@ ",s]];
            }
            else{
                [bestWordLabel addObject:@"_"];

                //[tempWord appendString:@"_ "];
            }
        }
        NSLog(@"best word label%@", bestWordLabel);
        
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
        
    NSLog(@"Dict with converted words%@", convertWords);
    
    //find the largest array of words
        NSArray *bestKey;
    NSInteger lengthArray = 0;
    for (id key in convertWords) {
        if ((NSInteger) [[convertWords objectForKey:key] count] > lengthArray){
            
            lengthArray = [[convertWords objectForKey:key] count];

            possibleWords = [convertWords objectForKey:key];
            bestKey = key;
        }
    }
        
        
        // if(!([key containsString:[NSString stringWithFormat:@"%@", letter]])){
        //update guesses value
        //}
        
    NSString * key = [bestKey componentsJoinedByString:@" "];
    self.wordLabel.text = key;
    NSLog(@"key %@", key);
        
    //waarde label samenvoegen met nieuwe key, array van maken
    //for loop over de lengte array
        
    

    
    NSLog(@"Possiblewords%@", possibleWords);
    return YES;
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


