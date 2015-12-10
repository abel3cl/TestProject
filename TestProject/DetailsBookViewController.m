//
//  DetailsBookViewController.m
//  Weekend1Work3-Books
//
//  Created by Abel Castro on 23/3/15.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "DetailsBookViewController.h"

@interface DetailsBookViewController ()

@end

@implementation DetailsBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lblNumberOfBook setNumberOfLines:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *mutableString = [NSString stringWithFormat:@"Book Number: %@ - Title: %@",_numberOfBook,_titleOfBook];
    
    
    self.lblNumberOfBook.text = mutableString;
    self.lblTitleOfChapter.text = _titleOfChapter;
    self.lblPagesCount.text = _pagesCount;
}

- (IBAction)btnBack:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
