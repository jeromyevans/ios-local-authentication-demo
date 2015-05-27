//
//  PasswordViewController.m
//  LocalAuthentication
//
//  Created by Jeromy Evans (personal) on 27/05/2015.
//  Copyright (c) 2015 Jeromy Evans. All rights reserved.
//

#import "PasswordViewController.h"
#import "A0SimpleKeychain.h"


@interface PasswordViewController ()

@property (strong, nonatomic) IBOutlet UITextField *loginPasswordTextField;
@property (strong, nonatomic) IBOutlet UIButton *LoginButton;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginPasswordTextField.delegate = self;
    
    [self.loginPasswordTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.loginPasswordTextField) {
        [textField resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (IBAction)didLogin:(id)sender {
    NSString* enteredPassword = self.loginPasswordTextField.text;
    
    if ([self checkPassword:enteredPassword]) {
        NSLog(@"Password valid.");

        [self performSegueWithIdentifier:@"PasswordAuthSuccess" sender:nil];
    }
    else {
        NSLog(@"Password not valid.");
    
        [self performSegueWithIdentifier:@"PasswordAuthFailed" sender:nil];
    }
}

/*
 Check the entered password against the password stored in the keychain
*/
- (BOOL)checkPassword:enteredPassword {
    
    NSLog(@"Checking password against keychain.");

    NSString *password = [[A0SimpleKeychain keychain] stringForKey:kKeychainPasswordKey];
    
    if (password == nil) {
         NSLog(@"There is no password in the keychain.");
    }
    
    return password != nil && [password isEqualToString:enteredPassword];
}

@end
