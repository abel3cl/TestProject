//
//  Chapter.m
//  Weekend1Work3-Books
//
//  Created by Abel Castro on 23/3/15.
//  Copyright (c) 2015 TAE. All rights reserved.
//

#import "Chapter.h"

@implementation Chapter

-(id) initWithTitleOfChapter: (NSString*) titleOfChapter withPageCount: (int) pageCountOfChapter
{
    self = [super init];
    
    if(self) {
        _titleOfChapter = titleOfChapter;
        _pageCountOfChapter = pageCountOfChapter;
    }
    
    return self;
}
@end
