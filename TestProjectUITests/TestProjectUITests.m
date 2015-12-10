//
//  TestProjectUITests.m
//  TestProjectUITests
//
//  Created by Abel Castro on 10/12/15.
//
//

#import <XCTest/XCTest.h>

@interface TestProjectUITests : XCTestCase

@end

@implementation TestProjectUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    XCUIApplication *app =[[XCUIApplication alloc] init];
    [app launch];
    
    
    XCUIElement *textField = [app.textFields elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"hunger games"];
    
    XCUIElement *returnButton = app.buttons[@"Return"];
    [returnButton tap];
    
    XCUIElement *textField2 = [app.textFields elementBoundByIndex:1];
    [textField2 tap];
    
    XCUIElement *moreNumbersKey = app.keys[@"more, numbers"];
    [moreNumbersKey tap];
    [textField2 typeText:@"123"];
    [returnButton tap];
    [app.steppers.buttons[@"Increment"] tap];
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



-(void) testAddSecondBook
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    XCUIElementQuery *titleElementsQuery = [app.otherElements containingType:XCUIElementTypeStaticText identifier:@"Title"];
    XCUIElement *textField = [[titleElementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"harry potter"];
    
    XCUIElement *returnButton = app.buttons[@"Return"];
    [returnButton tap];
    
    XCUIElement *textField2 = [[titleElementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1];
    [textField2 tap];
    
    XCUIElement *moreNumbersKey = app.keys[@"more, numbers"];
    [moreNumbersKey tap];
    [textField2 typeText:@"123"];
    [returnButton tap];
    
    [app.steppers.buttons[@"Increment"] tap];
    
}

-(void) testDeleteBook {
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"hunger games"] tap];
    [app.steppers.buttons[@"Decrement"] tap];
    
}

-(void) testAddChapter
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    
    [app.segmentedControls.buttons[@"hunger games"] tap];
    
    
    
    XCUIElementQuery *titleElementsQuery = [app.otherElements containingType:XCUIElementTypeStaticText identifier:@"Title"];
    XCUIElement *textField = [[titleElementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    [textField typeText:@"mockingjay"];
    
    XCUIElement *returnButton = app.buttons[@"Return"];
    [returnButton tap];
    
    XCUIElement *textField2 = [[titleElementsQuery childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:1];
    [textField2 tap];
    
    XCUIElement *moreNumbersKey = app.keys[@"more, numbers"];
    [moreNumbersKey tap];
    [textField2 typeText:@"111"];
    [returnButton tap];
    
    NSUInteger count = app.tables[@"tableOfBooks"].cells.count;
    [app.buttons[@"Add Chapter"] tap];
    
    XCTAssertEqual(app.tables[@"tableOfBooks"].cells.count, (count + 1));
}

-(void) testDeleteChapter
{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [self testAddChapter];
    
    XCTAssert(app.buttons[@"Add Chapter"].exists);
    [app.switches[@"1"] tap];
    XCTAssert(app.buttons[@"Remove Chapter"].exists);
    
    
    [app.tables.staticTexts[@"mockingjay"] tap];
    [app.buttons[@"Remove Chapter"] tap];
    [app.sheets[@"Would you like to delete the chapter? - mockingjay"].collectionViews.buttons[@"Delete"] tap];
    
}
-(void) testPagePushed
{
    // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [self testAddChapter];
    XCUIElement *mockingjayStaticText = app.tables[@"tableOfBooks"].staticTexts[@"mockingjay"];
    [mockingjayStaticText tap];
    
    XCTAssert(app.staticTexts[@"titleOfBook"].exists);
    
    
}

@end