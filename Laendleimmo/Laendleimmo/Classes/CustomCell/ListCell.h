//
//  ListCell.h
//  Laendleimmo
//
//  Created by Piyush08 on 22/05/15.
//  Copyright (c) 2015 Russmedia Tech PVT. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property(nonatomic,retain)IBOutlet UIImageView *img;
@property(nonatomic,retain)IBOutlet UILabel *lbl_property;
//@property(nonatomic,retain)IBOutlet UILabel *lbl_imageCount;
@property (nonatomic,retain)IBOutlet UIButton *btn_imageCount;
@property(nonatomic,retain)IBOutlet UILabel *lbl_title;
@property(nonatomic,retain)IBOutlet UILabel *lbl_location;
@property(nonatomic,retain)IBOutlet NSLayoutConstraint *lbl_property_width;
@end
