//
//  BeerViewController.h
//  beer
//
//  Created by Ben Weitzman on 1/11/13.
//  Copyright (c) 2013 Ben Weitzman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeerViewController : UIViewController

@property (strong, nonatomic) NSDictionary *beerInfo;
@property (weak, nonatomic) IBOutlet UILabel *abvLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *beerImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end
