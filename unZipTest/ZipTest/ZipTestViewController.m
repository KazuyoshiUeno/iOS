//
//  ZipTestViewController.m
//  ZipTest
//
//  Created by 上野 一義 on 11/09/08.
//  Copyright 2011 株式会社PIVOT. All rights reserved.
//

#import "ZipTestViewController.h"

@implementation ZipTestViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSLog(@"-- viewDidLoad --");
    [super viewDidLoad];
    
    
    //----------------------------------------------------------------------------------------
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString *outPath = [paths objectAtIndex:0];
    
    NSString *inPath = [[NSBundle mainBundle] pathForResource:@"hoge"ofType:@"zip"];
    
    
    ZipArchive* za = [[ZipArchive alloc] init];
    if([za UnzipOpenFile:inPath])
    {
        BOOL ret = [za UnzipFileTo:[outPath stringByAppendingPathComponent:@"ext"] overWrite:YES];
        if(NO == ret) {
            // error handling
            NSLog(@"unzip error");
        }
        else
        {
        NSLog(@"unzip success");
        }
        [za UnzipCloseFile];
    }
    [za release];    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
