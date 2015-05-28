//
//  ViewController.m
//  Laendleimmo
//
//  Created by Piyush08 on 30/04/15.
//  Copyright (c) 2015 Russmedia Tech PVT. LTD. All rights reserved.
//

#import "ViewController.h"

#import "SVPullToRefresh.h"
#import "MacroSetting.h"
#import "APIList.h"
#import "ListCell.h"
#import "ListAd.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>
@interface ViewController ()

@end

@implementation ViewController

#pragma mark - SetUp
-(void)setup
{
    
     isopen = NO;
    menu_height.constant=0.0f;
    _menu.clipsToBounds = YES;
    
    arr_data=[[NSMutableArray alloc]init];
    
    //  SVPllToRefresh 
    __weak ViewController *weakSelf = self;
    // setup pull-to-refresh
    
    
    [self.tbl addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    _tbl.pullToRefreshView.arrowColor=RGBA(237, 0, 67, 1);
    _tbl.pullToRefreshView.textColor=RGBA(237, 0, 67, 1);
    //_tbl.pullToRefreshView.activityIndicatorViewColor=RGBA(237, 0, 67, 1);
    _tbl.pullToRefreshView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;

    
    // setup infinite scrolling
    [self.tbl addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];

    //  SVPllToRefresh 
    
    
    [self getTop_Property];
    
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
    
   
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back.png"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back.png"];
    
    //to disable swipe feature of navigation
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]
     forState:UIControlStateNormal]; // set searchbar button title as white color

}

#pragma mark - Gesture Regonizer Delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer isEqual:self.navigationController.interactivePopGestureRecognizer]) {
        
        return NO;
        
    } else {
        
        return YES;
        
    }
    
}


#pragma mark - Refresh
-(void)insertRowAtTop
{
   // sleep(4);
    __weak ViewController *weakSelf = self;
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [weakSelf.tbl.pullToRefreshView stopAnimating];
    });
}

-(void)insertRowAtBottom
{
    //sleep(4);
    __weak ViewController *weakSelf = self;
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

   [weakSelf.tbl.infiniteScrollingView stopAnimating];
    });
}

-(IBAction)show_menu:(id)sender
{
    /*
    //[self.pulldownMenu animateDropDown];
    [UIView animateWithDuration: 0.3f
                          delay: 0.1f
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if (isopen)
                         {
                             
                             //_menu.center = CGPointMake(_menu.frame.size.width / 2, -((_menu.frame.size.height / 2) + 64));
                             menu_height.constant=0.0f;
                             isopen = NO;
                         }
                         else
                         {
                             //_menu.center = CGPointMake(_menu.frame.size.width / 2, ((_menu.frame.size.height / 2) + 64));
                             menu_height.constant=241.0f;
                             isopen = YES;
                         }
                     }
                     completion:^(BOOL finished){
                     }];
     */
    
    if (!isopen){
    menu_height.constant = 242.0f;
        isopen=YES;
    }
    else{
        menu_height.constant = 0;
        isopen=NO;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];


}

#pragma mark -  API 
-(void)getTop_Property
{
    NSURL *url=[NSURL URLWithString:TopProperty];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                if(!error){
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                PSLog(@"%@", dict);
                if (dict) {
                    
                    for (int i=0; i<[[dict objectForKey:@"search_result"]count]; i++) {
                      
                        ListAd *ad=[[ListAd alloc]initWithDict:[[dict objectForKey:@"search_result"]objectAtIndex:i]];
                        [arr_data addObject:ad];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [_tbl reloadData];
                    });
                }
                }
            }] resume];
}

#pragma mark - TAbleView DataSource & Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_data.count;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"TOP IMMOBILIEN";
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    ListCell *cell=(ListCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
        cell=(ListCell*)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    
    ListAd *ad=[arr_data objectAtIndex:indexPath.row];
    
    PSLog(@"%@",[NSURL URLWithString:ad.img_url]);
    [cell.img sd_setImageWithURL:[NSURL URLWithString:ad.img_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
    }];
    
    cell.lbl_title.text=ad.title;
    cell.lbl_location.text=[NSString stringWithFormat:@"%@ %@ , %@",ad.area,ad.city, ad.country];
    [cell.btn_imageCount setTitle:[NSString stringWithFormat:@"%ld",ad.ImageCount] forState:UIControlStateNormal];
    //cell.lbl_imageCount.text=[NSString stringWithFormat:@"%ld",ad.ImageCount];
    
    if (IS_IPHONE_4_AND_OLDER || IS_IPHONE_5)
        cell.lbl_property_width.constant=250.0f;

    if (ad.RoomsCount!=0){
        cell.lbl_property.text=[NSString stringWithFormat:@"%@     |    %.2f m²    |    %ld Zimmer    |",ad.price, ad.LivingSpace,ad.RoomsCount];
        
    if (IS_IPHONE_4_AND_OLDER || IS_IPHONE_5)
        cell.lbl_property.text=[NSString stringWithFormat:@"%@  |  %.2f m²  |  %ld Zimmer  |",ad.price, ad.LivingSpace,ad.RoomsCount];
    }
    else
        cell.lbl_property.text=[NSString stringWithFormat:@"%@     |    %.2f m²    |",ad.price, ad.LivingSpace];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // setup initial state (e.g. before animation)
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    // define final state (e.g. after animation) & commit animation
    [UIView beginAnimations:@"scaleTableViewCellAnimationID" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.alpha = 1;
    cell.layer.transform = CATransform3DIdentity;
    [UIView commitAnimations];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Close Menu dropdown if it is open 
    if(isopen){
        menu_height.constant = 0;
        isopen=NO;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];

    }
      else
    [self performSegueWithIdentifier:@"movetodetail" sender:nil];
}

#pragma mark - SearchBar Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
