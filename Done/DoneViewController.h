//
//  DoneViewController.h
//  Done
//
//  Created by marcti on 2011/05/12.
//  Copyright 2011 MiFone (Pty) Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoneViewController : UIViewController <UITextFieldDelegate> {
    

//Declare variables
UIScrollView        *theScroller;
UITextField         *mynumberField;
UITextField         *mytextField;
UITextField         *atextField;	

BOOL				addDone;
BOOL				buttonAdded;

UIButton			*doneButton;

}
//Methods
-(void)addButtonToKeyboard;
-(IBAction)closeDefaultKeyboard;//Used to close Default keyboard on Exit event
//Variables
@property (nonatomic, readwrite) BOOL addDone;
@property (nonatomic, readwrite) BOOL buttonAdded;
@property (nonatomic, retain) UIButton *doneButton;
//Outlets
@property (readwrite, retain) IBOutlet UITextField *mynumberField;
@property (readwrite, retain) IBOutlet UITextField *mytextField;
@property (readwrite, retain) IBOutlet UITextField *atextField;
@property (nonatomic, retain) IBOutlet UIScrollView *theScroller;

@end
