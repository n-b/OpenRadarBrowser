//
//  DetailViewController.h
//  OpenRadarBrowser
//
//  Created by Nicolas Bouilleaud on 11/03/2015.
//  Copyright (c) 2015 Nicolas Bouilleaud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

