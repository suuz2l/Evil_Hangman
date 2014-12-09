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
    NSMutableArray *alfabet;
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
    
    //update the length of the string with the number of letters
    NSMutableString *word = [NSMutableString new];
    
    NSLog(@"%lu", (unsigned long)numLetters);
    for (int i = 1; i <= numLetters; i++) {
        [word appendString:@"_ "];
    }
    
    if ([sortedWords objectForKey:@"numLetters"]) {
        NSLog(@"yes");
    
    }
    
   // hoe krijg ik sortedWords hier??
   // sortedWords[value]
   // value moet numLetters zijn
    
  //  waarom update hij maar 1 letter?
  //  waarom update hij de settings niet gelijk?
    
    // show the word and guesses label
    self.wordLabel.text = word;
    self.guessesLabel.text = [NSString stringWithFormat:@"%d Guesses left", numGuesses];
    
    // create alfabet for the available letters left
     alfabet = [NSMutableArray arrayWithObjects:@"A", @"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    
}

- (void)wordList {
    // create an array of all the words in the plist file
    // [self wordlist]
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words_short" ofType:@"plist"];
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:path];
    
    
    sortedWords = [[NSMutableDictionary alloc] init];
    
    for (NSString *word in words) {
        // create NSString object of word length to serve as keys
        NSUInteger wordLength = [word length];
        NSString *intString = [NSString stringWithFormat:@"%d", wordLength];
    
        if ([sortedWords objectForKey:intString]){
            // add word to the array in the dictionary
            [[sortedWords objectForKey:intString] addObject:word];
        }
        else{
            // create new array with word and add key value pair to dictionary
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:word, nil];
            [sortedWords setObject:array forKey:[NSString stringWithFormat:@"%d", [word length]]];
        }
    }
}



//1 voor elk woord ga je eerst kijken hoeveel letters ze hebben en die zet je in een nieuwe array
//2 aan de hand van de letter die de gebruiker in typt kijk je naar alle woorden die die letter
//  op plaats 1 hebben en zet die in een equivalence class, daarna voor plaats 2 etc
//3 kies de class/array met de grootste lengte en laat de letter op de plek zien of je laat geen letter zien als de class zonder die letter groter is
//4 doe stap 2 opnieuw aan de hand van wat de gebruiker intypt



// maak een array aan met het alphabet en laat die zien, elke keer als gebruiker een letter daarvan kiest moet die uit die label verwijderd worden

// laat de letters zien die al gebruikt zijn
    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    {
   
    NSString * upperString = [string uppercaseString ];
    [alfabet removeObject:upperString];
    
    
    NSString * alfabetWithSpace = [alfabet componentsJoinedByString:@" "];
    self.alfabetLabel.text = alfabetWithSpace;
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
