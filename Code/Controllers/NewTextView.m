//
//  NewTextView.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewTextView.h"
#import "MBProgressHUD.h"

@interface NewTextView () <UIWebViewDelegate>

@end

@implementation NewTextView
@synthesize textView;
@synthesize text = _text;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.contentSizeForViewInPopover = CGSizeMake(620, 532);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    CGSize size = [self.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(620, 9999) lineBreakMode:UILineBreakModeWordWrap];
//    self.textView.text = self.text;
//    CGRect frame = self.textView.frame;
//    frame.size.height = size.height;
//    self.textView.frame = frame;
//    self.contentSizeForViewInPopover = size;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.textView loadHTMLString:@"" baseURL:nil];
    self.textView.delegate = self;
    [self.textView loadHTMLString:self.text baseURL:nil];
}

- (void)viewDidUnload
{
    [self setTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
