//
//  DoneViewController.m
//  Done
//
//  Created by Abdullah Md. Zubair on 2011/05/12.
//  Copyright 2012 Raihan.. All rights reserved.
//

#import "DoneViewController.h"

@implementation DoneViewController

@synthesize mynumberField,mytextField,addDone,doneButton,buttonAdded,theScroller,atextField; 


- (void)viewDidLoad
{
	[super viewDidLoad];
	
	//*** Set Scroller size
	theScroller.contentSize=CGSizeMake(280, 650);
	
	//Add observers for the respective notifications (depending on the os version)
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardDidShow:) 
													 name:UIKeyboardDidShowNotification 
												   object:nil];	

	} else {
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];
	}

}
#pragma mark -
#pragma mark DONE button for Numeric Keypad
- (void)keyboardWillShow: (NSNotification *)notification {
	if(!addDone){
		return;
	}else{
		if ([[[UIDevice currentDevice] systemVersion] floatValue] < 3.2) {
			[self performSelector:@selector(addHideKeyboardButtonToKeyboard) withObject:nil afterDelay:0];
		}
	}		
}
- (void)keyboardDidShow:(NSNotification *)notification {
	if(!addDone){
		return;
	}else{
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			[self performSelector:@selector(addHideKeyboardButtonToKeyboard) withObject:nil afterDelay:0];
		}
	}	
}
- (void)addHideKeyboardButtonToKeyboard {
	UIWindow *keyboardWindow = nil;
	for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]) {
		if (![[testWindow class] isEqual:[UIWindow class]]) {
			keyboardWindow = testWindow;
			break;
		}
	}
	if (!keyboardWindow) return;
	
	// Locate UIKeyboard.  
	UIView *foundKeyboard = nil;
	for (UIView *possibleKeyboard in [keyboardWindow subviews]) {
		
		// iOS 4 sticks the UIKeyboard inside a UIPeripheralHostView.
		if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"]) {
			possibleKeyboard = [[possibleKeyboard subviews] objectAtIndex:0];
		}                                                                                
		
		if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"]) {
			foundKeyboard = possibleKeyboard;
			break;
		}
	}
	
	if (foundKeyboard) {
		[self addButtonToKeyboard];
	}
}
-(void)addButtonToKeyboard {
	// create custom button
	doneButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	doneButton.frame = CGRectMake(0, 163, 106, 53);
	doneButton.adjustsImageWhenHighlighted = NO;
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.0) {
		[doneButton setImage:[UIImage imageNamed:@"DoneUp3.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown3.png"] forState:UIControlStateHighlighted];
	} else {        
		[doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
		[doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
	}
	[doneButton addTarget:self action:@selector(removeNumberKeyboardWhenDonePressed:) forControlEvents:UIControlEventTouchUpInside];
	// locate keyboard view
	UIView *keyboard;
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		keyboard = [tempWindow.subviews objectAtIndex:i];
		// keyboard found, add the button
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
			if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
				[keyboard addSubview:doneButton];
		} else {
			if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
				[keyboard addSubview:doneButton];
		}
	}
	buttonAdded = YES;
}
//Remove Number keyboard when you press DONE button - method defined in addButtonToKeyBoard
-(void)removeNumberKeyboardWhenDonePressed:(id)sender {
    [self.view endEditing:TRUE];
}
//Remove Default keyboard when you press DONE button - link to DID END ON EXIT event on all text fields
-(IBAction)closeDefaultKeyboard{
	
}
#pragma mark -
#pragma mark UITextFieldDelegate methods
//Used to determine whether we must add the Numpad during NSNotification observations and to remove the Numpad DONE button
//if the field is a numberfield, else to redisplay it from retained memory
//If you have more text fields, simply apply OR in IF statement (i.e. ||) to append additional text fields.
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	//if editing textfields, then set addDone to No so NSNotifications ignore creation of DONE button object
	
	if((textField == mynumberField)||(textField == atextField))
	{//What we must do for all text fields
		if (!addDone) 
		{
			addDone = YES;
			[self keyboardDidShow:nil];			
		}
	}
	else {
		//What we must do for all number fields
		if (addDone) 
		{
			addDone = NO;
			[doneButton removeFromSuperview];
			[doneButton release];
			doneButton = nil;
			
		}
	}	
}
#pragma mark -
#pragma mark Other Lifecycle
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    [super dealloc];
	[mynumberField release];
	[mytextField release];
	[doneButton release];
	[theScroller release];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
@end
