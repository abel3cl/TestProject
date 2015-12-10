//
//  DetailsBookViewController.h
//  Weekend1Work3-Books
//
//  Created by Abel Castro on 23/3/15.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsBookViewController : UIViewController

// Aditional
@property (strong,nonatomic) NSString *titleOfBook;

@property (strong, nonatomic) NSString *numberOfBook;
@property (strong, nonatomic) NSString *titleOfChapter;
@property (strong, nonatomic) NSString *pagesCount;

// UIControls
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOfBook;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleOfChapter;
@property (weak, nonatomic) IBOutlet UILabel *lblPagesCount;

// Actions
- (IBAction)btnBack:(id)sender;

@end
