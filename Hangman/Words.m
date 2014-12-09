//
//  Words.m
//  Hangman
//
//  Created by Suzanne van der Tweel on 09/12/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import "Words.h"

@interface Words ()

@end

@implementation Words

- (id)init {
    self = [super init];
    self.wordList = [[NSMutableArray alloc] init];
    
    
    // create an array of all the words in the plist file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words_short" ofType:@"plist"];
    self.wordList = [NSMutableArray arrayWithContentsOfFile:path];
    
    NSLog(@"%@", self.wordList);
    return self;
}

-(void)filterWordsLength:(NSInteger)length{
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *string, NSDictionary *bindings) {
        return [string length] == length;
    }];
    NSArray *filteredWords = [self.wordList filteredArrayUsingPredicate:predicate];
    self.wordList = [filteredWords mutableCopy];
}

@end
