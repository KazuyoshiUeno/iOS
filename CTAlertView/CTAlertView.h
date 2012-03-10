//
//  CTAlertView.h
//  viewBasedExample
//
//  Created by 上野 一義 on 11/10/25.
//  Copyright (c) 2011年 株式会社PIVOT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTAlertView;

typedef void (^CTAlertViewButtonCallback)(CTAlertView *alertView, NSInteger index);

@interface CTAlertView : UIAlertView <UIAlertViewDelegate> {
@private
    void (^willPresentCallback_)(CTAlertView *);
    void (^didPresentCallback_)(CTAlertView *);
    void (^willDismissCallback_)(CTAlertView *, NSInteger);
    void (^didDismissCallback_)(CTAlertView *, NSInteger);
    
    NSMutableArray *buttonCallbacks_;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle;

-(void)addButtonWithTitle:(NSString*)title callback:(CTAlertViewButtonCallback)callback;
-(void)setCancelButtonCallback:(CTAlertViewButtonCallback)block;
-(void)setWillPresentCallback:(void (^)(CTAlertView *alertView))block;
-(void)setDidPresentCallback:(void (^)(CTAlertView *alertView))block;
-(void)setWillDismissCallback:(void (^)(CTAlertView *alertView, NSInteger index))block;
-(void)setDidDismissCallback:(void (^)(CTAlertView *alertView, NSInteger index))block;

@end
