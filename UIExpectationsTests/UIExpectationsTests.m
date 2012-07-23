// UIExpectationsTests UIExpectationsTests.m
//
// Copyright © 2012, Roy Ratcliffe, Pioneering Software, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the “Software”), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND, EITHER
// EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
// OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
//
//------------------------------------------------------------------------------

#import "UIExpectationsTests.h"

#import <UIExpectations/UIExpectations.h>

@implementation UIExpectationsTests

- (void)testExpectationsDependency
{
	// Important note: for this to work you need -all_load (or equivalent) as
	// your other linker flags for the test target. Otherwise you will see an
	// "unrecognized selector sent to instance" exception.
	STAssertNoThrow([@(1+1) should:equal(@2)], nil);
}

- (void)testAutomationDependency
{
	STAssertNotNil([[UIAutomation targetClass] localTarget], nil);
	// Assert exactly the same thing. This time though, use an expectation.
	STAssertNoThrow([[UIAutomation localTarget] shouldNot:be_nil], nil);
}

/*
 * The iOS simulator status bar should contain Wi-Fi signal strength and battery
 * power indicators. Check their presence. This test assumes English as the
 * simulator language configuration.
 */
- (void)testSimulatorStatusBarElements
{
	NSMutableArray *labels = [NSMutableArray array];
	id elements = [[[[[UIAutomation targetClass] localTarget] frontMostApp] statusBar] elements];
	for (UIAElement *element in elements)
	{
		NSString *label = [element label];
		if (label)
		{
			[labels addObject:label];
		}
	}
	STAssertTrue([labels containsObject:@"3 of 3 bars, Wi-Fi signal strength"], nil);
	STAssertTrue([labels containsObject:@"100% battery power"], nil);
}

@end
