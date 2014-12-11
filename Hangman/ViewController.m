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



//1 voor elk woord ga je eerst kijken hoeveel letters ze hebben en die zet je in een nieuwe array
//2 aan de hand van de letter die de gebruiker in typt kijk je naar alle woorden die die letter
//  op plaats 1 hebben en zet die in een equivalence class, daarna voor plaats 2 etc
//3 kies de class/array met de grootste lengte en laat de letter op de plek zien of je laat geen letter zien als de class zonder die letter groter is
//4 doe stap 2 opnieuw aan de hand van wat de gebruiker intypt



// maak een array aan met het alphabet en laat die zien, elke keer als gebruiker een letter daarvan kiest moet die uit die label verwijderd worden

// laat de letters zien die al gebruikt zijn
    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:letter
    {
        
    // convert string into uppercase letter and remove the used letter from alfabet
    NSString * upperLetter = [letter uppercaseString];
    [alfabet removeObject:upperLetter];
        //[numGuesses -1];
    
    NSString * alfabetWithSpace = [alfabet componentsJoinedByString:@" "];
    self.alfabetLabel.text = alfabetWithSpace;
    
        
    //create an temporaty array for the equivalence classes with or without the used letter
    tempArrayWithLetter = [[NSMutableArray alloc] init];
    tempArrayWithoutLetter = [[NSMutableArray alloc] init];
    

    NSLog(@"%@", letter);

    NSMutableDictionary *convertWords = [[NSMutableDictionary alloc] init];
    NSMutableArray *sameValueWords = [[NSMutableArray alloc] init];
        
    //create a class with the words that contains the letter and a class with the words that do not contain the letter
    for (NSString *word in possibleWords){
        NSMutableString *tempWord = [[NSMutableString alloc] init];
        for(int index = 0; index < [word length]; index++){
            char character = [word characterAtIndex:index];
            NSString *s = [NSString stringWithFormat:@"%c", character];

            if([s isEqualToString:upperLetter]){
                [tempWord appendString:[NSString stringWithFormat:@"%@",s]];
            }
            else{
                [tempWord appendString:@"_"];
            }
        }
        // add the converted strings into the dictionary
        if ([convertWords objectForKey:tempWord]){
            // add word to dictionary with the converted string as key
            [[convertWords objectForKey:tempWord] addObject:word];
        }
        else{
            // add new array to dictionary for different converted string as key
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:word, nil];
            [convertWords setObject:array forKey:tempWord];
        }
    }
        
    NSLog(@"Dict with converted words%@", convertWords);
    
        
        //find the largest array of words
    NSInteger lengthArray = 0;
    for (id key in convertWords) {
        if ((NSInteger) [[convertWords objectForKey:key] count] > lengthArray){
            
            lengthArray = [[convertWords objectForKey:key] count];
            possibleWords = [convertWords objectForKey:key];
        }
        
    }
    NSLog(@"%ld", (long)lengthArray);
    NSLog(@"Possiblewords%@", possibleWords);
    //NSLog(@"%@", equivalenceClasses);
    return YES;
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


