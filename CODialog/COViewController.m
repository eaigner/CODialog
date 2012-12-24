//
//  COViewController.m
//  CODialog
//
//  Created by Erik Aigner on 12.04.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import "COViewController.h"

#import "CODialog.h"


@interface COViewController ()
@property (nonatomic, strong) CODialog *dialog;
@end

@implementation COViewController
@synthesize dialog;

- (void)viewDidAppear:(BOOL)animated {
  UIImage *image = [UIImage imageNamed:@"wallpaper.jpg"];
  UIColor *color = [UIColor colorWithPatternImage:image];
  
  self.view.backgroundColor = color;
  
  // Display dialog
  self.dialog = [CODialog dialogWithWindow:self.view.window];
  
  [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(advanceProgress:) userInfo:nil repeats:YES];
  
  [self showDefault:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)advanceProgress:(NSTimer *)sender {
  CGFloat progress = self.dialog.progress + 0.25;
  if (progress > 1.0) {
    progress = 0;
  }
  self.dialog.progress = progress;
}

- (void)hideAndShow:(id)sender {
  [self.dialog hideAnimated:NO];
  
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self.dialog showOrUpdateAnimated:NO];
  });
}

- (void)hideAnimatedAndShow:(id)sender {
  [self.dialog hideAnimated:YES];
  
  double delayInSeconds = 2.0;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self.dialog showOrUpdateAnimated:YES];
  });
}

- (void)showDefault:(id)sender {
  NSLog(@"default");
  
  [self.dialog resetLayout];
  
  self.dialog.dialogStyle = CODialogStyleDefault;
  self.dialog.title = @"Title";
  self.dialog.subtitle = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec at tincidunt arcu. Donec faucibus velit ac ante condimentum pulvinar. Aliquam eget urna vel tortor laoreet porttitor. Pellentesque molestie fringilla tortor, ut consectetur diam adipiscing sit amet.";
  
  [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
  [self.dialog addButtonWithTitle:@"Hide (A)" target:self selector:@selector(hideAnimatedAndShow:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showText:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

- (void)showText:(id)sender {
  NSLog(@"text");
  
  [self.dialog resetLayout];
  
  self.dialog.dialogStyle = CODialogStyleDefault;
  self.dialog.title = @"Text Fields";
  self.dialog.subtitle = @"Plenty of them";
  
  [self.dialog addTextFieldWithPlaceholder:@"User" secure:NO];
  [self.dialog addTextFieldWithPlaceholder:@"Password" secure:YES];
  [self.dialog addTextFieldWithPlaceholder:@"Pin" secure:YES];
  
  [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showIndeterminate:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

- (void)showIndeterminate:(id)sender {
  NSLog(@"indeterminate");
  
  // Display text values first
  NSLog(@"user: %@, pass: %@, pin %@",
        [self.dialog textForTextFieldAtIndex:0],
        [self.dialog textForTextFieldAtIndex:1],
        [self.dialog textForTextFieldAtIndex:2]);
  
  // Setup indeterminate dialog
  [self.dialog resetLayout];
  
  self.dialog.title = @"Indeterminate";
  self.dialog.dialogStyle = CODialogStyleIndeterminate;
  
  [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showDeterminate:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

- (void)showDeterminate:(id)sender {
  NSLog(@"determinate");
  
  [self.dialog resetLayout];
  
  self.dialog.title = @"Determinate";
  self.dialog.dialogStyle = CODialogStyleDeterminate;
  
  [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showCustomView:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

- (void)showCustomView:(id)sender {
  NSLog(@"custom");
  
  [self.dialog resetLayout];
  
  UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Octocat.png"]];
  view.frame = CGRectMake(0, 0, 128, 128);
  
  self.dialog.title = @"Custom";
  self.dialog.subtitle = @"Hi!";
  self.dialog.dialogStyle = CODialogStyleCustomView;
  self.dialog.customView = view;
  
  [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showSuccess:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

- (void)showSuccess:(id)sender {
  NSLog(@"success");
  
  self.dialog.title = @"Success";
  self.dialog.subtitle = nil;
  self.dialog.dialogStyle = CODialogStyleSuccess;
  
  [self.dialog removeAllButtons];
  [self.dialog addButtonWithTitle:@"Success" target:self selector:@selector(hideAndShow:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showError:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

- (void)showError:(id)sender {
  NSLog(@"error");
  
  [self.dialog resetLayout];
  
  self.dialog.title = @"Error";
  self.dialog.dialogStyle = CODialogStyleError;
  
  [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
  [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showDefault:) highlighted:YES];
  [self.dialog showOrUpdateAnimated:YES];
}

@end
