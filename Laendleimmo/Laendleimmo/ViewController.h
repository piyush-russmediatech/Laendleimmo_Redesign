//
//  ViewController.h
//  Laendleimmo
//
//  Created by Piyush08 on 30/04/15.
//  Copyright (c) 2015 Russmedia Tech PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{


    BOOL isopen;
   IBOutlet NSLayoutConstraint *menu_height;
    
}
@property (nonatomic, retain)IBOutlet UIView *menu;
@property (nonatomic, retain)IBOutlet UITableView *tbl;
-(IBAction)show_menu:(id)sender;

@end

