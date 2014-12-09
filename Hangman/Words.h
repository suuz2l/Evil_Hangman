//
//  Words.h
//  Hangman
//
//  Created by Suzanne van der Tweel on 09/12/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Words : UIViewController

@property NSMutableArray *wordList;

-(NSInteger)numberOfWords;
-(void)filterWordsLength:(NSInteger)length;


@end
