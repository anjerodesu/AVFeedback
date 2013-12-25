//
//  AVViewController.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import "AVViewController.h"
#import "AVFeedbackViewController.h"

@interface AVViewController ()

@end

@implementation AVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)feedbackButtonTapped:(id)sender
{
    AVFeedbackViewController *feedbackViewController = [AVFeedbackViewController controllerWithDefaultTopicsAndImages];
    feedbackViewController.toRecipients = @[@"AVFeedback@example.com"];
    [self.navigationController pushViewController:feedbackViewController animated:YES];
}

- (IBAction)modalFeedbackButtonTapped:(id)sender
{
    AVFeedbackViewController *feedbackViewController = [AVFeedbackViewController controllerWithDefaultTopics];
    feedbackViewController.toRecipients = @[@"AVFeedback@example.com"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
