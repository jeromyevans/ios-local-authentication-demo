//
//  FirstViewController.h
//  LocalAuthentication
//
//  Created by Jeromy Evans on 19/5/15.
//  Copyright (c) 2015 Jeromy Evans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FailureViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)savePasswordInKeychain:(id)sender;
- (IBAction)removePasswordFromKeychain:(id)sender;

@end