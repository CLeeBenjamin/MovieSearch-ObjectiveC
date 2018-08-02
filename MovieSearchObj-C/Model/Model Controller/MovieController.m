//
//  MovieController.m
//  MovieSearchObj-C
//
//  Created by Caston  Boyd on 6/6/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

#import "MovieController.h"
#import "Movie.h"

@implementation MovieController

//MARK: - URL and APIKey

static NSString * const apiKey = @"6a6fa20c1eb5b4e843966dbc33379ab5";

-(NSURL*) baseURL
{
    return [NSURL URLWithString:@"https://api.themoviedb.org/3/search/movie"];
    
}

-(NSURL*) imageURL
{
    return [NSURL URLWithString:@"http://image.tmdb.org/t/p/w250"];
}


//MARK: - Shared Instance

+ (instancetype) sharedInstance
{
    
    static MovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MovieController alloc]init];
    });
    
    return sharedInstance;
}


//MARK: - Method for Fetching URL for movie

- (void)fetchMoviesWith:(NSString *)searchInput completion:(void (^)(NSArray<Movie *> *, NSError *))completion
{
    //MARK: - URL
    NSURL * baseURL = [self baseURL];
    NSURLQueryItem *searchInputName = [NSURLQueryItem queryItemWithName:@"query" value:searchInput];
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value: apiKey];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    components.queryItems = @[searchInputName, apiKeyItem];
    NSURL *endpoint = components.URL;
    NSLog(@"%@", endpoint);
    
    
    //MARK: - Session Datatask
    [[[NSURLSession sharedSession] dataTaskWithURL:endpoint completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        if (error) {
            
            NSLog(@"%@", error.localizedDescription);
            return completion (nil, [NSError errorWithDomain:@"error Fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"Error: no data returned from task");
            return completion(nil, [NSError errorWithDomain:@"error Fetching Data" code:(NSInteger)-1 userInfo:nil]);
            
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *userInfo = nil;
            if (error) { userInfo = @{NSUnderlyingErrorKey : error};
            }
            NSLog(@"%@", error.localizedDescription);
            
            NSError *localError = [NSError errorWithDomain:@"com.CLB.MovieSearch.ErrorDomain" code:-1 userInfo:userInfo];
            return completion(nil, localError);
        }
        
        //MARK: - Holding for Movie items
        NSArray *movieList = jsonDictionary[@"results"];
        NSMutableArray *movieHolder = [[NSMutableArray alloc]init];
        for (NSDictionary *movieDictionary in movieList)
        {
            Movie *movie = [[Movie alloc] initWithDictionary: movieDictionary];
            
            if (movie) {[movieHolder addObject:movie];}
            [movieHolder addObject:movie];
            
            completion(movieHolder, nil);
        }
        
    }]resume]; ///Resume, URL Session Scope End
    
}



//MARK: - method for fetching images

- (void)fetchImagesWith:(NSString *)imageName completion:(void (^)(UIImage *))completion
{
    //MARK: - URL
    NSURL *baseImageURL = [NSURL URLWithString:@"http://image.tmdb.org/t/p/w500"];
    NSURL *imageEndpoint = [baseImageURL URLByAppendingPathComponent:imageName];
    
    
    //MARK: - Session Datatask
    [[[NSURLSession sharedSession] dataTaskWithURL:imageEndpoint completionHandler:^(NSData * data, NSURLResponse *  response, NSError *  error) {
        
        if (error) {
            NSLog(@"Error loadingimage: %@", error);
            completion(nil);
            return;
        }
        if (!data) {
            NSLog(@"Error: Not data return from data task for image");
            completion(nil);
            return;
        }
        
        UIImage *movieImage = [[UIImage alloc] initWithData:data];
        
        completion(movieImage);
        
        
    }] resume];/// Resume, URL Session Scope End
        
}

@end
