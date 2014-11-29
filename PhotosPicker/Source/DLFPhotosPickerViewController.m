//
//  DLFPhotosPickerViewController.m
//  PhotosPicker
//
//  Created by  on 11/28/14.
//  Copyright (c) 2014 Delightful. All rights reserved.
//

#import "DLFPhotosPickerViewController.h"

#import "DLFMasterViewController.h"
#import "DLFDetailViewController.h"
#import "DLFPhotosSelectionManager.h"

@interface DLFPhotosPickerViewController () <DLFMasterViewControllerDelegate, DLFDetailViewControllerDelegate>

@end

@implementation DLFPhotosPickerViewController

- (void)awakeFromNib {
    self.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[DLFPhotosSelectionManager sharedManager] removeAllAssets];
    
    self.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.viewControllers.count > 1) {
        UINavigationController *firstVC = [self.viewControllers firstObject];
        UINavigationController *secondVC = [self.viewControllers lastObject];
        
        DLFMasterViewController *masterVC = [firstVC.viewControllers firstObject];
        DLFDetailViewController *detailVC = [secondVC.viewControllers firstObject];
        
        [masterVC setDelegate:self];
        [detailVC setDelegate:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
   showDetailViewController:(UINavigationController *)vc
                     sender:(id)sender {
    DLFDetailViewController *controller1 = [vc.viewControllers firstObject];
    controller1.delegate = self;
    return NO;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UINavigationController *)secondaryViewController
  ontoPrimaryViewController:(UINavigationController *)primaryViewController {
    DLFDetailViewController *controller1 = [secondaryViewController.viewControllers firstObject];
    DLFMasterViewController *controller2 = [primaryViewController.viewControllers firstObject];
    controller1.delegate = self;
    controller2.delegate = self;
    return NO;
}

- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController
separateSecondaryViewControllerFromPrimaryViewController:(UINavigationController *)primaryViewController {
    DLFMasterViewController *controller1 = [primaryViewController.viewControllers firstObject];
    controller1.delegate = self;
    return nil;
}

#pragma mark - DLFMasterViewControllerDelegate

- (void)masterViewController:(DLFMasterViewController *)masterViewController didTapCancelButton:(UIButton *)sender {
    if (self.photosPickerDelegate && [self.photosPickerDelegate respondsToSelector:@selector(photosPickerDidCancel:)]) {
        [self.photosPickerDelegate photosPickerDidCancel:self];
    }
}

#pragma mark - DLFDetailViewControllerDelegate

- (void)detailViewController:(DLFDetailViewController *)detailViewController didTapNextButton:(UIButton *)nextButton photos:(NSArray *)photos {
    if (self.photosPickerDelegate && [self.photosPickerDelegate respondsToSelector:@selector(photosPicker:detailViewController:didSelectPhotos:)]) {
        [self.photosPickerDelegate photosPicker:self detailViewController:detailViewController didSelectPhotos:photos];
    }
}

@end
