//
//  ListAd.h
//  Laendleimmo
//
//  Created by Piyush08 on 22/05/15.
//  Copyright (c) 2015 Russmedia Tech PVT. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListAd : NSObject

@property(nonatomic,assign)NSInteger AdID;
@property(nonatomic,retain)NSString *area,*city,*country;
@property(nonatomic,assign)float lati, longi;
@property(nonatomic,retain)NSString *img_url;
@property(nonatomic,retain)NSString *isReserved,*isSold;
@property(nonatomic,assign)float LandArea,LivingSpace;
@property(nonatomic,assign)NSInteger ImageCount,RoomsCount;
@property(nonatomic,retain)NSString *price,*status,*title;
//@property(nonatomic,retain)NSInteger AdID;

-(id)initWithDict:(NSDictionary *)dict;

@end
