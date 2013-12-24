//
//  AVFeedbackViewController.m
//  AVFeedbackDemo
//
//  Created by Angelo Villegas on 12/23/13.
//  Copyright (c) 2013 Studio Villegas. All rights reserved.
//

#import "AVFeedbackViewController.h"
#import "AVPlatform.h"
#import "AVFeedbackTopicsViewController.h"
#import "NSBundle+AVFeedback.h"

#import "AVFeedbackCell.h"
#import "AVFeedbackCellItem.h"
#import "AVFeedbackContentCellItem.h"
#import "AVFeedbackInfoCellItem.h"
#import "AVFeedbackTopicCellItem.h"

typedef NS_ENUM(NSInteger, AVFeedbackSection) {
    AVFeedbackSectionInput,
    AVFeedbackSectionDeviceInfo,
    AVFeedbackSectionAppInfo
};

@interface AVFeedbackViewController ()

@property (nonatomic, readonly) NSUInteger selectedTopicIndex;

@property (nonatomic, strong) NSArray *cellItems;

@property (nonatomic, readonly) NSArray *inputCellItems;
@property (nonatomic, readonly) NSArray *deviceInfoCellItems;
@property (nonatomic, readonly) NSArray *appInfoCellItems;
@property (nonatomic, strong) AVFeedbackTopicCellItem *topicCellItem;
@property (nonatomic, strong) AVFeedbackContentCellItem *contentCellItem;

@property (nonatomic, readonly) NSString *mailSubject;
@property (nonatomic, readonly) NSString *mailBody;

@end

@implementation AVFeedbackViewController

+ (AVFeedbackViewController *)controllerWithDefaultLocalizedTopics
{
	return [[AVFeedbackViewController alloc] initWithTopics: AVFeedbackViewController.defaultTopics localizedTopics:AVFeedbackViewController.defaultLocalizedTopics];
}

+ (AVFeedbackViewController *)controllerWithTopics:(NSArray *)topics localizedTopics:(NSDictionary *)localizedTopics
{
    return [[AVFeedbackViewController alloc] initWithTopics:topics localizedTopics:localizedTopics];
}

+ (NSArray *)defaultTopics
{
    return @[@"Support", @"Request", @"Bug Report", @"Other"];
}

+ (NSDictionary *)defaultLocalizedTopics
{
    return @{AVFeedbackLocalizedString(@"Support"): @"support.png", AVFeedbackLocalizedString(@"Request"): @"request.png", AVFeedbackLocalizedString(@"Bug Report"): @"bug.png", AVFeedbackLocalizedString(@"Other"): @"other.png"};
}

- (instancetype)initWithTopics:(NSArray *)topics localizedTopics:(NSDictionary *)localizedTopics
{
    self = [super initWithStyle:UITableViewStyleGrouped];
	
    if (self)
	{
        self.topics = topics;
        self.localizedTopics = localizedTopics;
    }
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = AVFeedbackLocalizedString(@"Feedback");

    [self.tableView registerClass:[AVFeedbackCell class] forCellReuseIdentifier:[AVFeedbackTopicCellItem reuseIdentifier]];
    [self.tableView registerClass:[AVFeedbackCell class] forCellReuseIdentifier:[AVFeedbackContentCellItem reuseIdentifier]];
    [self.tableView registerClass:[AVFeedbackCell class] forCellReuseIdentifier:[AVFeedbackInfoCellItem reuseIdentifier]];

    self.cellItems = @[self.inputCellItems, self.deviceInfoCellItems, self.appInfoCellItems];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:AVFeedbackLocalizedString(@"Mail") style:UIBarButtonItemStylePlain target:self action:@selector(sendButtonTapped:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.presentingViewController.presentedViewController)
	{
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped:)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.contentCellItem removeObserver:self forKeyPath:AVContentCellItemCellHeightKey];
}

#pragma mark - Key value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:AVContentCellItemCellHeightKey])
	{
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

#pragma mark -

- (void)cancelButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setTopics:(NSArray *)topics
{
    _topics = topics;

    self.selectedTopic = _topics.count >= 1 ? _topics[0] : @"";
}

- (NSUInteger)selectedTopicIndex
{
    return [self.topics indexOfObject:self.selectedTopic];
}

- (NSArray *)inputCellItems
{
    NSMutableArray *result = [NSMutableArray array];

    __weak typeof (self) weakSelf = self;

    self.topicCellItem = [AVFeedbackTopicCellItem new];
	NSArray *allKeys = [self.localizedTopics allKeys];
    self.topicCellItem.topic = allKeys[self.selectedTopicIndex];
    self.topicCellItem.action = ^(AVFeedbackViewController *sender) {
        AVFeedbackTopicsViewController *topicsViewController = [[AVFeedbackTopicsViewController alloc] initWithStyle:UITableViewStyleGrouped];
        topicsViewController.topics = sender.topics;
        topicsViewController.localizedTopics = sender.localizedTopics;
        topicsViewController.action = ^(NSString *selectedTopic) {
            weakSelf.selectedTopic = selectedTopic;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:AVFeedbackSectionInput];
            AVFeedbackTopicCellItem *cellItem = weakSelf.cellItems[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
			NSArray *weakKeys = [weakSelf.localizedTopics allKeys];
            cellItem.topic = weakKeys[weakSelf.selectedTopicIndex];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };

        [sender.navigationController pushViewController:topicsViewController animated:YES];
    };
    [result addObject:self.topicCellItem];

    self.contentCellItem = [AVFeedbackContentCellItem new];
    [self.contentCellItem addObserver:self forKeyPath:AVContentCellItemCellHeightKey options:NSKeyValueObservingOptionNew context:nil];
    [result addObject:self.contentCellItem];

    return result.copy;
}

- (NSArray *)deviceInfoCellItems
{
    NSMutableArray *result = [NSMutableArray array];
	
	AVPlatform *platform = [AVPlatform sharedPlatform];
    AVFeedbackInfoCellItem *platformItem = [AVFeedbackInfoCellItem new];
    platformItem.title = AVFeedbackLocalizedString(@"Device");
    platformItem.value = platform.platformString;
    [result addObject:platformItem];

    AVFeedbackInfoCellItem *systemVersionItem = [AVFeedbackInfoCellItem new];
    systemVersionItem.title = AVFeedbackLocalizedString(@"iOS");
    systemVersionItem.value = platform.systemVersion;
    [result addObject:systemVersionItem];

    return result.copy;
}

- (NSArray *)appInfoCellItems
{
    NSMutableArray *result = [NSMutableArray array];
	AVPlatform *platform = [AVPlatform sharedPlatform];
	
    AVFeedbackInfoCellItem *nameItem = [AVFeedbackInfoCellItem new];
    nameItem.title = AVFeedbackLocalizedString(@"Name");
    nameItem.value = platform.appName;
    [result addObject:nameItem];

    AVFeedbackInfoCellItem *versionItem = [AVFeedbackInfoCellItem new];
    versionItem.title = AVFeedbackLocalizedString(@"Version");
    versionItem.value = platform.appVersion;
    [result addObject:versionItem];

    AVFeedbackInfoCellItem *buildItem = [AVFeedbackInfoCellItem new];
    buildItem.title = AVFeedbackLocalizedString(@"Build");
    buildItem.value = platform.appBuild;
    [result addObject:buildItem];

    return result.copy;
}

- (NSString *)mailSubject
{
	AVPlatform *platform = [AVPlatform sharedPlatform];
    return [NSString stringWithFormat:@"%@: %@", platform.appName, self.topics[self.selectedTopicIndex]];
}

- (NSString *)mailBody
{
	AVPlatform *platform = [AVPlatform sharedPlatform];
    NSString *content = self.contentCellItem.textView.text;
    NSString *body = [NSString stringWithFormat:@"%@\n\n\nDevice: %@\niOS: %@\nApp: %@\nVersion: %@\nBuild: %@", content, platform.platformString, platform.systemVersion, platform.appName, platform.appVersion, platform.appBuild];
    return body;
}

- (void)sendButtonTapped:(id)sender
{
    MFMailComposeViewController *controller = [MFMailComposeViewController new];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:_toRecipients];
    [controller setCcRecipients:_ccRecipients];
    [controller setBccRecipients:_bccRecipients];
    [controller setSubject:self.mailSubject];
    [controller setMessageBody:self.mailBody isHTML:NO];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellItems[(NSUInteger)section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AVFeedbackCellItem *cellItem = self.cellItems[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[[cellItem class] reuseIdentifier] forIndexPath:indexPath];

    [cellItem configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
	{
        case AVFeedbackSectionDeviceInfo:
            return AVFeedbackLocalizedString(@"Device Info");
        case AVFeedbackSectionAppInfo:
            return AVFeedbackLocalizedString(@"App Info");
        case AVFeedbackSectionInput:
        default:
            return nil;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AVFeedbackCellItem *cellItem = self.cellItems[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
    return cellItem.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AVFeedbackCellItem *cellItem = self.cellItems[(NSUInteger)indexPath.section][(NSUInteger)indexPath.row];
    if (cellItem.action) cellItem.action(self);
	
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.contentCellItem.textView resignFirstResponder];
}

#pragma mark - MFMailComposeViewController delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    void (^completion)(void) = ^{
        if (self.presentingViewController.presentedViewController)
		{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
		else
		{
            [self.navigationController popViewControllerAnimated:YES];
        }
    };

    if (result == MFMailComposeResultCancelled)
	{
        completion = nil;
    }
	else if (result == MFMailComposeResultFailed && error)
	{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AVFeedbackLocalizedString(@"Error")
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:AVFeedbackLocalizedString(@"Dismiss")
                                              otherButtonTitles:nil];
        [alert show];
    }

    [controller dismissViewControllerAnimated:YES completion:completion];
}

@end
