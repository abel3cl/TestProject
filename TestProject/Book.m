//
//  Book.m
//  Weekend1Work3-Books
//
//  Created by Abel Castro on 23/3/15.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "Book.h"

@implementation Book

-(id) initWithTitle: (NSString*) titleBook
{
    self = [super init];
    
    if(self) {
        _titleBook = titleBook;
        _arrayOfChapters = [[NSMutableArray alloc] init];
    }
    
    return self;
}


@end
