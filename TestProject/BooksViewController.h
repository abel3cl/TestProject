//
//  BooksViewController.h
//  Weekend1Work3-Books
//
//  Created by Abel Castro on 23/3/15.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "BookTableViewCell.h"
#import "DetailsBookViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BooksViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) NSMutableArray *arrayOfBooks;

// UIControls
@property (weak, nonatomic) IBOutlet UITableView *tableOfBooks;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleBookChapter;
@property (weak, nonatomic) IBOutlet UITextField *txtTitleBookChapter;
@property (weak, nonatomic) IBOutlet UITextField *txtPageCount;
@property (weak, nonatomic) IBOutlet UIStepper *stpAddRemoveBook;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmNumberOfBooks;
@property (weak, nonatomic) IBOutlet UISwitch *swtChangeAddRemove;
@property (weak, nonatomic) IBOutlet UIButton *btnAddRemoveChapter;

// Actions
- (IBAction)btnAddRemoveChapter:(id)sender;

@end
