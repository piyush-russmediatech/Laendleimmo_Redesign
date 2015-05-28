//
//  SearchVC.h
//  Laendleimmo
//
//  Created by Piyush08 on 01/05/15.
//  Copyright (c) 2015 Russmedia Tech PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController
<UIGestureRecognizerDelegate,UISearchBarDelegate>

@property (nonatomic, retain)IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain)IBOutlet UISlider *slider;
@property (nonatomic, retain)IBOutlet UILabel *lbl_radius;

-(IBAction) act_Slider_change:(UISlider*)sender;
@end
