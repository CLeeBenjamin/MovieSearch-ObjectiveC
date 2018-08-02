//
//  MovieController.h
//  MovieSearchObj-C
//
//  Created by Caston  Boyd on 6/6/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@class Movie;

NS_ASSUME_NONNULL_BEGIN

@interface MovieController : NSObject

//MARK: - Shared Instance
+(instancetype) sharedInstance;


//MARK: - Class Methods

-(void) fetchMoviesWith: (NSString*) userSearchTerm completion: (void (^) (NSArray <Movie *> *movies, NSError *error)) completion;


//look up completion handlers
-(void)fetchImagesWith:(NSString*)imageName completion:(void (^)(UIImage *))completion;

NS_ASSUME_NONNULL_END

@end
