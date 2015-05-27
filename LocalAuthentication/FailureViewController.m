//
//  FailureViewController.m
//  LocalAuthentication
//
//  Created by Jeromy Evans on 19/5/15.
//  Copyright (c) 2015 Jeromy Evans. All rights reserved.
//

#import "FailureViewController.h"

@import Security;
#import "A0SimpleKeychain.h"

@implementation FailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.passwordTextField) {
        [textField resignFirstResponder];
        [self savePasswordInKeychain];
        
        return NO;
    }
    
    return YES;
}

- (void)savePasswordInKeychain {
   
    [[A0SimpleKeychain keychain] setString:self.passwordTextField.text forKey:kKeychainPasswordKey];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password saved in keychain."
                                                    message:@"Your password has been saved in the keychain"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)removePasswordFromKeychain {
    
    [[A0SimpleKeychain keychain] deleteEntryForKey:kKeychainPasswordKey];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password removed from keychain."
                                                    message:@"Your password has been removed from the keychain."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)savePasswordInKeychain:(id)sender {
    
    [self savePasswordInKeychain];
}

- (IBAction)removePasswordFromKeychain:(id)sender {
    
    [self removePasswordFromKeychain];
    
}


@end
