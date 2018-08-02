//
//  Movie.m
//  MovieSearchObj-C
//
//  Created by Caston  Boyd on 6/6/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype)init
{
    return [self initWithTitle:@"" image:@"" ratings: 0 overview:@""];
}


-(instancetype)initWithTitle:(NSString *)title image:(NSString *)image ratings:(NSNumber *)ratings overview:(NSString *)overview

{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _image = [image copy];
        _ratings = [ratings copy];
        _overview = [overview copy];
        
    }
    return self;
}

@end


@implementation Movie (JSONConvert)


-(instancetype) initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    
    for (NSDictionary * movieDictionary in dictionary)
    {
        NSString *title = dictionary[@"title"];
        NSNumber *ratings = dictionary[@"vote_average"];
        NSString *overview = dictionary[@"overview"];
        NSString *image = dictionary[@"poster_path"];
        
        return [self initWithTitle:title image:image ratings:ratings overview:overview];
    }
    
    return nil;
}



@end
