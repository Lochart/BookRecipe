//
//  Recipes+CoreDataProperties.h
//  RecipeBook
//
//  Created by Nikolay on 13.12.15.
//  Copyright © 2015 Nikolay. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Recipes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recipes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *nameRecipe;
@property (nullable, nonatomic, retain) NSString *ingredientsRecipe;

@end

NS_ASSUME_NONNULL_END
