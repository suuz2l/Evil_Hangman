//
//  ViewController.m
//  Hangman
//
//  Created by Suzanne van der Tweel on 14/11/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //vraag waarde op voor letters
    //zo nee standaard waarde en anders
    
    
    
    
    NSUInteger letters = [defaults integerForKey:@"letters"];
    NSLog(@"%lu", (unsigned long)letters);
    if(letters== 0){
        
        [defaults setInteger:7 forKey:@"letters"];
        
    }
    
    letters = [defaults integerForKey:@"letters"];
    NSLog(@"%lu", (unsigned long)letters);
    
    NSUInteger guesses = [defaults integerForKey:@"guesses"];
    NSMutableString *word = [NSMutableString new];

    //update the length of the string with the number of letters
    for (int i = 1; i <= letters; i++) {
        [word appendString:@"_ "];
    }
    self.wordLabel.text = word;
    

    self.guessesLabel.text = [NSString stringWithFormat:@"%d Guesses left", (int)guesses];
    
    
}

- (void)wordList {
    // create an array of all the words in the plist file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words_short" ofType:@"plist"];
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:path];
    
    NSLog(@"%@", words);
    
}

-(void)filterWordsLength{




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
    self.letterLabel.text = [NSString stringWithFormat:@"%@%@", self.letterLabel.text, string];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
