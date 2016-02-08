//
//  ShowRecipe.m
//  RecipeBook
//
//  Created by Nikolay on 14.12.15.
//  Copyright © 2015 Nikolay. All rights reserved.
//

#import "Recipes.h"
#import "ShowRecipe.h"

@interface ShowRecipe ()
@property (strong) NSManagedObject *recipe;

@property (weak, nonatomic) IBOutlet UILabel *titleRecipe;
@property (weak, nonatomic) IBOutlet UILabel *compositionAndIngredients;

- (IBAction)Edit:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@implementation ShowRecipe

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.recipe) {
        [self.titleRecipe setText:[self.recipe valueForKey:@"nameRecipe"]];
        [self.compositionAndIngredients setText:[self.recipe valueForKey:@"ingredientsRecipe"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)Edit:(id)sender {
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
