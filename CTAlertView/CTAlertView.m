//
//  CTAlertView.m
//  viewBasedExample
//
//  Created by 上野 一義 on 11/10/25.
//  Copyright (c) 2011年 株式会社PIVOT. All rights reserved.
//

#import "CTAlertView.h"

@interface CTAlertView ()

@property (nonatomic, retain) NSMutableArray *buttonCallbacks;

- (BOOL)hasCancelButton;

@end

@implementation CTAlertView

@synthesize buttonCallbacks=buttonCallbacks_;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
{
    self = [super initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        self.delegate = self;
        self.buttonCallbacks = [NSMutableArray array];
        if ([self hasCancelButton]) {
            [self setCancelButtonCallback:^(CTAlertView *alertView, NSInteger index){}];
        }
    }
    return self;
}

- (void)dealloc
{
    [willPresentCallback_ release];
    [didPresentCallback_ release];
    [willDismissCallback_ release];
    [didDismissCallback_ release];
    self.buttonCallbacks = nil;
    
    [super dealloc];
}

-(void)addButtonWithTitle:(NSString*)title callback:(CTAlertViewButtonCallback)callback
{
    id obj = [NSNull null];
    if (callback) obj = [[callback copy] autorelease];
    
    [self addButtonWithTitle:title];
    [self.buttonCallbacks addObject:obj];
}

-(void)setCancelButtonCallback:(CTAlertViewButtonCallback)callback
{
    if (![self hasCancelButton]) return;
    
    if ([self.buttonCallbacks count] > 0) {
        [self.buttonCallbacks removeObjectAtIndex:0];
    }
    
    [self.buttonCallbacks insertObject:[[callback copy] autorelease] atIndex:0];
}

-(void)setWillPresentCallback:(void (^)(CTAlertView *alertView))block
{
    [willPresentCallback_ release];
    willPresentCallback_ = [block retain];
}

-(void)setDidPresentCallback:(void (^)(CTAlertView *alertView))block
{
    [didPresentCallback_ release];
    didPresentCallback_ = [block retain];
}

-(void)setWillDismissCallback:(void (^)(CTAlertView *alertView, NSInteger index))block
{
    [willDismissCallback_ release];
    willDismissCallback_ = [block retain];
}

-(void)setDidDismissCallback:(void (^)(CTAlertView *alertView, NSInteger index))block
{
    [didDismissCallback_ release];
    didDismissCallback_ = [block retain];
}

- (BOOL)hasCancelButton
{
    return (self.cancelButtonIndex == 0);
}

#pragma mark -
#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    id callback = [self.buttonCallbacks objectAtIndex:buttonIndex];
    if (![callback isMemberOfClass:[NSNull class]]) {
        ((CTAlertViewButtonCallback)callback)((CTAlertView *)alertView, buttonIndex);
    }
}

-(void)willPresentAlertView:(UIAlertView *)alertView
{
    if(willPresentCallback_) willPresentCallback_((CTAlertView *)alertView);
}

-(void)didPresentAlertView:(UIAlertView *)alertView
{
    if(didPresentCallback_) didPresentCallback_((CTAlertView *)alertView);
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(willDismissCallback_) willDismissCallback_((CTAlertView *)alertView, buttonIndex);
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(didDismissCallback_) didDismissCallback_((CTAlertView *)alertView, buttonIndex);
}

@end