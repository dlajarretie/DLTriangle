//
//  DLTriangleTests.m
//  RayTriangleIntersection
//
//  Created by Damien Lajarretie on 20/06/2015.
//  Copyright (c) 2015 Damien Lajarretie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "DLTriangle.h"

@interface DLTriangleTests : XCTestCase {
    DLTriangle* triangle;
    DLTriangle* flatTriangle;
    GLKVector3 rayOrigin;
}

@end

@implementation DLTriangleTests

- (void)setUp {
    [super setUp];
    
    rayOrigin = GLKVector3Make(0, 0, 0);
    
    GLKVector3 vectors[3] = {   GLKVector3Make(0, 0, 1),
                                GLKVector3Make(0, 1, 0),
                                GLKVector3Make(1, 0, 0) };
    
    GLKVector3 flatTriangleVectors[3] = {   GLKVector3Make(1, 1, 0),
                                            GLKVector3Make(1, -1, 1),
                                            GLKVector3Make(1, -1, -1) };
    
    triangle = [[DLTriangle alloc] initWithVectors:vectors];
    flatTriangle = [[DLTriangle alloc] initWithVectors:flatTriangleVectors];
}

- (void)tearDown {
    [super tearDown];
}

-(void) testTriangleInitialization {
    
    BOOL vector1Equal = GLKVector3AllEqualToVector3( [triangle getVector:0], GLKVector3Make(0, 0, 1) );
    BOOL vector2Equal = GLKVector3AllEqualToVector3( [triangle getVector:1], GLKVector3Make(0, 1, 0) );
    BOOL vector3Equal = GLKVector3AllEqualToVector3( [triangle getVector:2], GLKVector3Make(1, 0, 0) );
    
    XCTAssert(vector1Equal && vector2Equal && vector3Equal, @"Triangle vectors should be properly assigned");
}

-(void) testNoIntersectionWithRay {

    GLKVector3 rayDirection = GLKVector3Make(-1, -1, -1);
    
    XCTAssertFalse([triangle intersectsRayWithOrigin:rayOrigin direction:rayDirection intersectionDistance:nil], @"Ray should not intersect triangle");
}

-(void) testIntersectionWithRay {

    GLKVector3 rayDirection = GLKVector3Make(1, 1, 1);

    BOOL intersects = [triangle intersectsRayWithOrigin:rayOrigin direction:rayDirection intersectionDistance:nil];

    XCTAssert(intersects, @"Ray should intersect triangle");
}

-(void) testIntersectionDistance {
    
    GLKVector3 rayDirection = GLKVector3Make(1, 0, 0);
    
    float distance;
    
    BOOL intersects = [flatTriangle intersectsRayWithOrigin:rayOrigin direction:rayDirection intersectionDistance:&distance];
    
    XCTAssert(intersects && distance == 1.0f, @"Intersection distance should be 1.0");
}

-(void) testIntersectionCoordinates {
    
    GLKVector3 rayDirection = GLKVector3Make(1, 0, 0);
    
    GLKVector3 intersection = [flatTriangle intersectionPointWithRayWithOrigin:rayOrigin direction:rayDirection];
    
    XCTAssert(GLKVector3AllEqualToVector3(intersection, GLKVector3Make(1, 0, 0)), @"Intersection point should be {1,0,0}");
}


@end
