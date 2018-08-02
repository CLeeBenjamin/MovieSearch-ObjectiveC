//
//  Movie.h
//  MovieSearchObj-C
//
//  Created by Caston  Boyd on 6/6/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

//MARK: - Headers for Properties

NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *image;
@property (nonatomic, readonly) NSNumber *ratings;
@property (nonatomic, copy, readonly) NSString *overview;


-(instancetype) initWithTitle: (NSString *) title image: (NSString *) image ratings: (NSNumber *) ratings overview: (NSString *) overview;

NS_ASSUME_NONNULL_END

@end


@interface Movie (JSONConvert)


NS_ASSUME_NONNULL_BEGIN

-(instancetype) initWithDictionary: (NSDictionary<NSString*, id> *)dicionary; 


NS_ASSUME_NONNULL_END
@end
