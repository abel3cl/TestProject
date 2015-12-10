//
//  BooksViewController.m
//  Weekend1Work3-Books
//
//  Created by Abel Castro on 23/3/15.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "BooksViewController.h"

@interface BooksViewController ()

@end

@implementation BooksViewController
{
    MBProgressHUD *hud;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableOfBooks.accessibilityLabel = @"tableOfBooks";
    [self.sgmNumberOfBooks removeAllSegments];
    [self initStepper];
    [self initSwitch];
    
    _arrayOfBooks = [[NSMutableArray alloc]init];
    
    // register for notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataSource and Delegate of UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_arrayOfBooks count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_arrayOfBooks objectAtIndex:section] arrayOfChapters] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"Cell";
    
    BookTableViewCell *bookCell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if(bookCell == nil)
    {
        bookCell = [[BookTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    
    //Set up my cell
    bookCell.lblTitleOfChapter.text = [[[[_arrayOfBooks objectAtIndex:indexPath.section] arrayOfChapters] objectAtIndex:indexPath.row] titleOfChapter ] ;
    int pageCount = [[[[_arrayOfBooks objectAtIndex:indexPath.section] arrayOfChapters] objectAtIndex:indexPath.row] pageCountOfChapter];
    bookCell.lblPageCount.text = [NSString stringWithFormat:@"%d",pageCount];
    
    return bookCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[_arrayOfBooks objectAtIndex:section] titleBook];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self shouldPerformSegueWithIdentifier:@"viewDetailsChapter" sender:self];
}

#pragma mark - Implementation of segue
// Check if switch is On
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([self.swtChangeAddRemove isOn])
        return YES;

    return NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get path of the row selected
    NSIndexPath *indexPath = [self.tableOfBooks indexPathForSelectedRow];
    
    DetailsBookViewController *detailsBookVC = [segue destinationViewController];
    // Add +1, it's not showing book number 0. Starts the count in 1
    [detailsBookVC setNumberOfBook: [NSString stringWithFormat:@"%ld", (long)indexPath.section +1]];
    
    [detailsBookVC setTitleOfChapter: [[[[_arrayOfBooks objectAtIndex:indexPath.section] arrayOfChapters] objectAtIndex:indexPath.row] titleOfChapter]];
    
    [detailsBookVC setPagesCount: [NSString stringWithFormat:@"%ld",(long)[[[[_arrayOfBooks objectAtIndex:indexPath.section] arrayOfChapters] objectAtIndex:indexPath.row] pageCountOfChapter]]];
    
    [detailsBookVC setTitleOfBook:[[_arrayOfBooks objectAtIndex: indexPath.section] titleBook]];
    
}

#pragma mark - Additional delete option
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // remove chapter from the array
        [[[_arrayOfBooks objectAtIndex:indexPath.section ]arrayOfChapters] removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
    }
}
// End DataSource and delegate UITableView --------------------------------------------------------------//

#pragma mark - Stepper Functionality
// Stepper Functionality
-(void) initStepper {
    [self.stpAddRemoveBook addTarget:self action:@selector(addRemoveBook:) forControlEvents:UIControlEventValueChanged];
}

-(void) addRemoveBook: (UIStepper*) stepper
{
    //Check if user pressed + or -
    //If new value is greater than number of books. +pressed
    if([stepper value ]> [_arrayOfBooks count])
    {
        hud = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:hud];
        hud.delegate = self;
        hud.mode = MBProgressHUDModeDeterminate;
        hud.labelText = @"Loading";
        hud.progress = 0.0;

        //Create book and
        NSString *titleOfBook = self.txtTitleBookChapter.text;
        
        //Check title is not empty
        if ( [titleOfBook isEqualToString:@""] ? YES : NO) {
            [[[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Title can't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
        else {
            Book *newBook = [[Book alloc] initWithTitle:titleOfBook];
        
            [hud showAnimated:YES whileExecutingBlock:^{
                
                
                for (int i = 0; i < 600; i++) {
                    NSLog(@"%u",i);
                    hud.progress = i/600.0;
                }
                
            } completionBlock:^{}];
            //Update segmentControl
            [self.sgmNumberOfBooks insertSegmentWithTitle:titleOfBook atIndex:[_arrayOfBooks count] animated:YES];
        
            //add it to the array
            [_arrayOfBooks addObject:newBook];
    
            [self.tableOfBooks reloadData];
            [self clearFields];
        }
    }
    else {
        //Update segmentControl
        [self.sgmNumberOfBooks removeSegmentAtIndex:[_arrayOfBooks count] -1  animated:YES];
        //Remove from the array
        [_arrayOfBooks removeLastObject];
        
        [self.tableOfBooks reloadData];
    }
}

#pragma mark - Switch functionallity
// Switch functionallity
-(void) initSwitch {
        [self.swtChangeAddRemove addTarget:self action:@selector(changeAddRemoveChapter:) forControlEvents:UIControlEventValueChanged];
}

-(void) changeAddRemoveChapter: (UISwitch*) switchAddremoveChapter
{
    if([self.swtChangeAddRemove isOn])
    {
        //Enable pageCount text field
        self.txtPageCount.enabled = YES;
        //addRemoveChapter button its called add chapter
        [self.btnAddRemoveChapter setTitle:@"Add Chapter" forState:UIControlStateNormal];
    }
    else
    {
        //Disable pageCount text field
        self.txtPageCount.enabled = NO;
        //addRemoveChapter button its called remove chapter
        //If we change manually self.btnAddRemoveChapter.titleLabel.text it won't persist
        [self.btnAddRemoveChapter setTitle:@"Remove Chapter" forState:UIControlStateNormal];
        
        
    }
}

#pragma mark - btnAddRemoveChapter functionallity
// Button AddRemoveChapter functionallity
- (IBAction)btnAddRemoveChapter:(id)sender
{
    //Add Chapter
    if([self.swtChangeAddRemove isOn])
    {
        // Book selected
        int indexBookSelected = [self.sgmNumberOfBooks selectedSegmentIndex];
        
        //check there is a book selected
        if(indexBookSelected >= 0) {
            
            NSString *titleOfChapter = self.txtTitleBookChapter.text;
            NSString *stringPageCount = self.txtPageCount.text;
            if([self checkWithTitle: titleOfChapter withPagesCount: stringPageCount]) {
                // If
                int numberOfPagesCount = [self.txtPageCount.text integerValue];

                Chapter *newChapter = [[Chapter alloc] initWithTitleOfChapter:titleOfChapter withPageCount:numberOfPagesCount];
        
                [[[_arrayOfBooks objectAtIndex:indexBookSelected] arrayOfChapters] addObject:newChapter];
        
                [self.tableOfBooks reloadData];
                [self clearFields];
                
            }
        }
        else {
            [[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Select one Book" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
    }
    //Remove Chapter
    else {
        // Get path of the row selected
        NSIndexPath *indexPath = [self.tableOfBooks indexPathForSelectedRow];
        if(indexPath == nil) {
            [[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Select one Chapter from the table" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
        else {
            //Ask user
            NSString *titleOfChapter = [NSString stringWithFormat:@"Would you like to delete the chapter? - %@", [[[[_arrayOfBooks objectAtIndex:indexPath.section] arrayOfChapters] objectAtIndex:indexPath.row] titleOfChapter]];
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:titleOfChapter delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:nil];
            
            [actionSheet showInView:self.view];
        }
    }    
}

#pragma mark - ActionSheet Options
// ActionSheet Options
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *titlePressedButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    // Always compare with titles rather than index
    if([titlePressedButton isEqualToString:@"Delete"])
    {
         NSIndexPath *indexPath = [self.tableOfBooks indexPathForSelectedRow];
        [[[_arrayOfBooks objectAtIndex:indexPath.section] arrayOfChapters] removeObjectAtIndex:indexPath.row];
        
        [self.tableOfBooks reloadData];
    }
}

#pragma mark - Other methods
// Check inputs of title and pageCount for a chapter
-(BOOL) checkWithTitle:(NSString*) titleOfChapter withPagesCount:(NSString*) pagesCount
{
    BOOL validTitle = ([titleOfChapter isEqualToString:@""]) ? NO : YES;
    BOOL validPagesCount = YES;
    
    //Assuming a chapter has a minimun that 1 page
    if([pagesCount isEqualToString:@""]) {
        validPagesCount = NO;
    }
    
    NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [pagesCount length]; ++i)
    {
        unichar c = [pagesCount characterAtIndex:i];
        if (![numberCharSet characterIsMember:c])
        {
            validPagesCount = NO;
        }
    }
    
    if( !validTitle ) {
        [[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Title of Chapter can't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return NO;
    }
    else if ( !validPagesCount ) {
        [[[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Invalid number of pages" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        return NO;
    }
    return YES;
    
}

// Clear textFields after addition of book of chapter
-(void) clearFields
{
    self.txtPageCount.text  = @"";
    self.txtTitleBookChapter.text = @"";
}

// Drop the keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) keyboarWillShowNotification: (NSNotification*) notification
{
    NSDictionary *info = notification.userInfo;
    
    __weak BooksViewController *weakSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frameView = weakSelf.view.frame;
        frameView.origin.y -= 253.0;
        weakSelf.view.frame = frameView;
    }];
}



-(void) keyboarWillHideNotification: (NSNotification*) notification
{
    NSDictionary *info = notification.userInfo;
    __weak BooksViewController *weakSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frameView = weakSelf.view.frame;
        frameView.origin.y = 0;
        weakSelf.view.frame = frameView;
    }];
}
@end
