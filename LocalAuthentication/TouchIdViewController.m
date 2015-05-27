//
//  ViewController.m
//  LocalAuthentication
//
//  Created by Jeromy Evans on 18/5/15.
//  Copyright (c) 2015 Jeromy Evans. All rights reserved.
//

#import "TouchIdViewController.h"

@import LocalAuthentication;
@import Security;
#import "A0SimpleKeychain.h"

@implementation TouchIdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [self authenticateWithTouchId];
}



- (void)didAuthenticateWithTouchId {

    [self performSegueWithIdentifier:@"AuthenticationSuccess" sender:nil];
}

- (void)didFailAuthenticationWithTouchId {

    [self performSegueWithIdentifier:@"ShowPasswordAuth" sender:nil];

}

- (void)authenticateWithTouchId {
    LAContext *localAuthContext = [[LAContext alloc] init];
    
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Authenticate to access the app.";
    
    if ([localAuthContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        
        NSLog(@"Biometric authentication is available.");
        
        [localAuthContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                                reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                    NSLog(@"User authenticated successfully");
                                    // dispatch async so the several second delay after
                                    // successful auth don't block the UI
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self didAuthenticateWithTouchId];
                                    });
                                }
                                else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                    NSLog(@"Authentication failed: %@", [error localizedDescription]);

                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self didFailAuthenticationWithTouchId];
                                    });
                                }
                            }];
    }
    else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
        NSLog(@"Biometric authentication is not available. %@", authError.localizedDescription);
        
        [self didFailAuthenticationWithTouchId];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToAuthentication:(UIStoryboardSegue *)unwindSegue {

    [self authenticateWithTouchId];

}

@end
