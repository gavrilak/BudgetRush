//
//  DSTourViewController.m
//  BudgetRush
//
//  Created by Dima Soladtenko on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSTourViewController.h"
#import "TAPageControl.h"

@interface DSTourViewController () <UIScrollViewDelegate, TAPageControlDelegate>

@property (weak, nonatomic) IBOutlet TAPageControl *customStoryboardPageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)skipAction:(id)sender;


@property (strong, nonatomic) NSArray *imagesData;


@end

@implementation DSTourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imagesData = @[@"1.jpg", @"2.png", @"1.jpg", @"2.png"];
    
     [self setupScrollViewImages];
    
    // TAPageControl from storyboard
    self.customStoryboardPageControl.delegate = self;
    self.customStoryboardPageControl.numberOfPages = self.imagesData.count;
   
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    

    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.imagesData.count, CGRectGetHeight(self.view.frame));
}


#pragma mark - ScrollView delegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    self.customStoryboardPageControl.currentPage = pageIndex;
    
}


// Example of use of delegate for second scroll view to respond to bullet touch event
- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)index
{
    NSLog(@"Bullet index %ld", (long)index);
    [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.scrollView.frame) * index, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame)) animated:YES];
}


#pragma mark - Utils


- (void)setupScrollViewImages
{
  
    [self.imagesData enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"%f,%ld",CGRectGetWidth(self.view.frame),idx);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) * idx, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }];

}

#pragma mark - Actions

- (IBAction)skipAction:(id)sender{
    
    [self performSegueWithIdentifier:@"showTabBar" sender:self];
}


@end
