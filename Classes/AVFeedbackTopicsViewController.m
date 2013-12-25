//
//  AVFeedbackTopicsViewController.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import "AVFeedbackTopicsViewController.h"
#import "NSBundle+AVFeedback.h"

static NSString *AVFeedbackTopicsViewControllerCellIdentifier = @"Cell";

@interface AVFeedbackTopicsViewController ()

@end

@implementation AVFeedbackTopicsViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = AVFeedbackLocalizedString(@"Topics");
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AVFeedbackTopicsViewControllerCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
	NSString *topic = nil;
	if ([_topics isKindOfClass: [NSDictionary class]])
	{
		NSArray *allKeys = [_topics allKeys];
		topic = allKeys[indexPath.row];
		UIImage *image = [UIImage imageNamed: _topics[allKeys[indexPath.row]]];
		cell.imageView.image = image;
		cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
		cell.imageView.clipsToBounds = YES;
	}
	else
	{
		topic = _topics[indexPath.row];
	}
	
	cell.imageView.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = topic;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_topics count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AVFeedbackTopicsViewControllerCellIdentifier forIndexPath:indexPath];

    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedTopic = self.topics[indexPath.row];
    if (self.action) self.action(selectedTopic);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
