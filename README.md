AVFeedback
==========

Most developers encounter difficult problem of having their app ratings go down because of unwanted feedbacks made by the user that is mostly caused by the users doesn't want a feature added or removed, crashing on a specific device, etc... . This is a small feedback library for developers to use in their app to help them decrease (if not at all remove) these kind of app ratings in the app store (better than 1 star review).

<!-- ![Screenshot](https://raw.github.com/rizumita/AVFeedback/master/AVFeedback.png) -->

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
AVFeedbackViewController *feedbackViewController = [AVFeedbackViewController controllerWithTopics:AVFeedbackViewController.defaultTopics localizedTopics:AVFeedbackViewController.defaultLocalizedTopics];
feedbackViewController.toRecipients = @[@"AVFeedback@example.com"];
[self.navigationController pushViewController:feedbackViewController animated:YES];
```

License
----------

Source code is under the [MIT license](https://github.com/anjerodesu/AVFeedback/blob/master/LICENSE)

__Icons__ by [Glyphish](http://glyphish.com/)  
Artwork is under Glyphish's separate [license](http://www.glyphish.com/license.txt)