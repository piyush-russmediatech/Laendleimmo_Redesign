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

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - SetUp
-(void)setup
{
    
     isopen = NO;
    menu_height.constant=0.0f;
    _menu.clipsToBounds = YES;
    
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
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
    
   
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back.png"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back.png"];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }

    
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
    menu_height.constant = 241;
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

#pragma mark - TAbleView DataSource & Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"TOP IMMOBILIEN";
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
