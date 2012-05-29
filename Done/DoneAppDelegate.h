//
//  DoneAppDelegate.h
//  Done
//
//  Created by Abdullah Md. Zubair on 2011/05/12.
//  Copyright 2012 Raihan.. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DoneViewController;

@interface DoneAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet DoneViewController *viewController;

@end
