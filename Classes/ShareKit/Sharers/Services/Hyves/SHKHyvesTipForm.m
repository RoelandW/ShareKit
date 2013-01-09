//
//  SHKHyvesTipForm.m
//  ShareKit+Hyves
//
//  Created by Martijn de Haan on 9/7/10.

//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//

#import "SHKHyvesTipForm.h"
#import "SHK.h"
#import "SHKHyves.h"
#import "SHKHyvesTopAlignedTableViewCell.h"
#import "SHKHyvesTableViewCellWithRating.h"

#import "UITableViewCell+PMEasy.h"

@implementation SHKHyvesTipForm

@synthesize bodyTextView = _bodyTextView;
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style 
{
    if ((self = [super initWithStyle:style])) 
    {
		_bodyTextView = [[UITextView alloc] initWithFrame:CGRectMake(97, 5, 200, 200.0f)];
		_bodyTextView.font = [UIFont systemFontOfSize:16.0f];
		_bodyTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_bodyTextView.autocorrectionType = UITextAutocorrectionTypeNo;
		_bodyTextView.backgroundColor = [UIColor clearColor];
		
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																							  target:self
																							  action:@selector(cancel)] autorelease];
		
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:SHKLocalizedString(@"Send")
																				  style:UIBarButtonItemStyleDone
																				 target:self
																				 action:@selector(save)] autorelease];
		[_bodyTextView becomeFirstResponder];
	}
    return self;
}

- (void)cancel
{	
	[[SHK currentHelper] hideCurrentViewControllerAnimated:YES];
}

- (void)save
{	
	if ( ! _bodyTextView.text || [_bodyTextView.text isEqualToString:@""] ) {
		
		[[[[UIAlertView alloc] initWithTitle:SHKLocalizedString(@"No message given")
									 message:SHKLocalizedString(@"Please enter a message for this Tip.")
									delegate:nil
						   cancelButtonTitle:SHKLocalizedString(@"Close")
						   otherButtonTitles:nil] autorelease] show];
		return;
	}	

    //TODO: the actual protocol is not being used, but the delegate is used as pointer to the SHKHyves instance
	if([_delegate respondsToSelector:@selector(sendForm:)]) {
		[(SHKHyves *)_delegate sendForm:_bodyTextView.text];	
	}
    
	[[SHK currentHelper] hideCurrentViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath 
{
	return 200.0f;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"SHKHyvesCell";
	
	SHKHyvesTopAlignedTableViewCell *cell = (SHKHyvesTopAlignedTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];

	if (cell == nil)
	{
		cell = (SHKHyvesTopAlignedTableViewCell*)[[SHKHyvesTopAlignedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}

	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.keyLabel.text = @"WWW";
    cell.keyLabel.textColor = [UIColor lightGrayColor];
    cell.keyLabel.font = [UIFont systemFontOfSize:16.0f];
    [cell.contentView addSubview:_bodyTextView];

	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
	[_bodyTextView release];
    [super dealloc];
}

@end

