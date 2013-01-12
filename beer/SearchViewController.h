//
//  SearchViewController.h
//  beer
//
//  Created by Ben Weitzman on 1/11/13.
//  Copyright (c) 2013 Ben Weitzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
- (IBAction)search:(id)sender;

@end
