//
//  ViewController.m
//  RImageView
//
//  Created by ricky on 13-3-30.
//  Copyright (c) 2013年 ricky. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+RExtension.h"

@interface ViewController ()
@property (nonatomic, assign) IBOutlet UIImageView *imageView1;
@property (nonatomic, assign) IBOutlet UIImageView *imageView2;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.imageView1 setGifImage:@"1.gif"];
    [self.imageView2 setGifImage:@"2.gif"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
