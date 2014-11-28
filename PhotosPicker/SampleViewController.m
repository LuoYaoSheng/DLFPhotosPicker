//
//  SampleViewController.m
//  PhotosPicker
//
//  Created by  on 11/28/14.
//  Copyright (c) 2014 Delightful. All rights reserved.
//

#import "SampleViewController.h"

#import "DLFPhotosPickerViewController.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapPickPhotos:(id)sender {
    DLFPhotosPickerViewController *photosPicker = [[UIStoryboard storyboardWithName:@"PhotosPicker" bundle:nil] instantiateInitialViewController];
    [self presentViewController:photosPicker animated:YES completion:nil];
}
@end
