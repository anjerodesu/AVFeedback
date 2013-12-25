AVFeedback
==========
Most developers encounter difficult problem of having their app ratings go down because of unwanted feedbacks made by the user that is mostly caused by the users who doesn't want a specific feature added or removed, crashing on a specific device, etc... . This is a small feedback library for developers to use in their app to help them decrease (if not at all remove) these kind of app ratings in the app store (better than 1 star review).

Install
----------
To  install  by  CocoaPods
```Ruby
platform :ios, '7.0'
pod 'AVFeedback'
```

Example
----------
```Objective-C
AVFeedbackViewController *feedbackViewController = [AVFeedbackViewController controllerWithDefaultTopicsAndImages];
feedbackViewController.toRecipients = @[@"AVFeedback@example.com"];
[self.navigationController pushViewController:feedbackViewController animated:YES];
```

#### Returning your own list of topics
```Objective-C
+ (NSArray *)defaultTopics
{
    return @[@"Support", @"Request", @"Bug Report", @"Other"];
}

+ (NSDictionary *)defaultTopicsAndImages;
{
    return @{@"Support": @"support.png", @"Request": @"request.png", @"Bug Report": @"bug.png", @"Other": @"other.png"};
}
```

The `defaultTopics` is an array of strings and `defaultLocalizedTopics` is a dictionary of localized string and images.

Localisation
----------
Localised in 4 different languages
- English
- Russian
- Japanese
- Chinese (Simplified)

License
----------
Source code is under the [MIT license](https://github.com/anjerodesu/AVFeedback/blob/master/LICENSE)

__Icons__ by [Glyphish](http://glyphish.com/)  
Artwork is under Glyphish's separate [license](http://www.glyphish.com/license.txt)
