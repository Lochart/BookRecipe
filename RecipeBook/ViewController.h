//
//  ViewController.h
//  RecipeBook
//
//  Created by Nikolay on 13.12.15.
//  Copyright © 2015 Nikolay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong) NSManagedObject *recipe;

@end

