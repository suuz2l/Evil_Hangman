//
//  ViewController.h
//  Hangman
//
//  Created by Suzanne van der Tweel on 14/11/14.
//  Copyright (c) 2014 Suzanne van der Tweel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, readwrite, weak) IBOutlet UITextField * _textField;
@property (nonatomic, strong) IBOutlet UIButton * _settingsbutton;
@end

