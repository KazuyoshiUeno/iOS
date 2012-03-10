//
//  ZipTestAppDelegate.h
//  ZipTest
//
//  Created by 上野 一義 on 11/09/08.
//  Copyright 2011 株式会社PIVOT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZipTestViewController;

@interface ZipTestAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ZipTestViewController *viewController;

@end
