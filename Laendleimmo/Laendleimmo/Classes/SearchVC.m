//
//  SearchVC.m
//  Laendleimmo
//
//  Created by Piyush08 on 01/05/15.
//  Copyright (c) 2015 Russmedia Tech PVT. LTD. All rights reserved.
//

#import "SearchVC.h"

@interface SearchVC ()

@end

@implementation SearchVC


-(void)setup
{
    self.title = @"Suche";
    
    _searchBar.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    _searchBar.layer.borderWidth = 1.0f;

    [_slider setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateNormal];
    [_slider setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateSelected];
    [_slider setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Slider Value Change
-(IBAction)act_Slider_change:(UISlider *)sender
{
    _lbl_radius.text=[NSString stringWithFormat:@"%d km",(int)sender.value];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
