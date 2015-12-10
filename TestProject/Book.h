//
//  Book.h
//  Weekend1Work3-Books
//
//  Created by Abel Castro on 23/3/15.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chapter.h"
@interface Book : NSObject

@property (strong, nonatomic) NSString *titleBook;
@property (strong, nonatomic) NSMutableArray *arrayOfChapters;

-(id) initWithTitle: (NSString*) titleBook;
@end
