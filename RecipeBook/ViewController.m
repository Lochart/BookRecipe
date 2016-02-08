//
//  ViewController.m
//  RecipeBook
//
//  Created by Nikolay on 13.12.15.
//  Copyright © 2015 Nikolay. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Recipes.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleNameRecipe;
@property (weak, nonatomic) IBOutlet UIImageView *imageDish;
@property (weak, nonatomic) IBOutlet UITextView *ingredientRecipe;
@property (nonatomic) NSMutableArray *capturedImages;
@property (nonatomic) UIImagePickerController *imagePickerController;

- (IBAction)saveRecipe:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)addImage:(id)sender;

@end

@implementation ViewController

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.capturedImages = [[NSMutableArray alloc]init];
    
    if (self.recipe) {
        [self.titleNameRecipe setText:[self.recipe valueForKey:@"nameRecipe"]];
        [self.ingredientRecipe setText:[self.recipe valueForKey:@"ingredientsRecipe"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveRecipe:(id)sender {
    [self newRecipe];
    [self message];
}

- (IBAction)addImage:(id)sender {
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType{

    if (self.imageDish.isAnimating) {
        [self.imageDish stopAnimating];
    }
    
    if (self.capturedImages.count > 0) {
        [self.capturedImages removeAllObjects];
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

-(void)finishAndUpdate{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if ([self.capturedImages count] > 0) {
        if ([self.capturedImages count] == 1) {
            [self.imageDish setImage:[self.capturedImages objectAtIndex:0]];
        } else {
            self.imageDish.animationImages = self.capturedImages;
            self.imageDish.animationDuration = 5.0;
            self.imageDish.animationRepeatCount = 0;
            [self.imageDish startAnimating];
        }
        
        [self.capturedImages removeAllObjects];
    }
    
    self.imagePickerController = nil;
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.capturedImages addObject:image];
    
    [self finishAndUpdate];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)newRecipe{
    AppDelegate *appDelegate = [self appDelegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    if (self.recipe) {
        [self.recipe setValue:self.titleNameRecipe.text forKey:@"nameRecipe"];
        [self.recipe setValue:self.ingredientRecipe.text forKey:@"ingredientsRecipe"];
    }else{
    Recipes *newRecipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipes" inManagedObjectContext:context];
    [newRecipe setValue:self.titleNameRecipe.text forKey:@"nameRecipe"];
    [newRecipe setValue:self.ingredientRecipe.text forKey:@"ingredientsRecipe"];
    }
    
    [appDelegate saveContext];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Congratulations"
                                                   message:@"You have added a new recipe in my recipe book"
                                                  delegate:nil
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
    [alert show];
}

-(AppDelegate *)appDelegate{
    return [[UIApplication sharedApplication]delegate];
}

@end
