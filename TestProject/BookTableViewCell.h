//
//  BookTableViewCell.h
//  Weekend1Work3-Books
//
//  Created by Abel Castro on 23/3/15.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitleOfChapter;
@property (weak, nonatomic) IBOutlet UILabel *lblPageCount;
@end
