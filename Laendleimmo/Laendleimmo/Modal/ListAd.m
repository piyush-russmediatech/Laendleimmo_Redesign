//
//  ListAd.m
//  Laendleimmo
//
//  Created by Piyush08 on 22/05/15.
//  Copyright (c) 2015 Russmedia Tech PVT. LTD. All rights reserved.
//

#import "ListAd.h"

@implementation ListAd

-(id)initWithDict:(NSDictionary *)dict{
self = [super init];
if(self)
{
    _AdID = [[dict objectForKey:@"adid"]integerValue];
    _area=[dict objectForKey:@"area"];
    _city=[dict objectForKey:@"city"];
    _lati=[[dict valueForKeyPath:@"coordinate.latitude"]floatValue];
    _longi=[[dict valueForKeyPath:@"coordinate.longitude"]floatValue];
    _country=[dict objectForKey:@"county"];
    _img_url=[dict objectForKey:@"image_url"];
    _isReserved=[dict objectForKey:@"isReserved"];
    _isSold=[dict objectForKey:@"isSold"];
    _LivingSpace=[[dict objectForKey:@"livingspace"]floatValue];
    _LandArea=[[dict objectForKey:@"landarea"]floatValue];
    if(_LandArea==0)
        _LandArea=_LivingSpace;
    _ImageCount=[[dict objectForKey:@"noOfImages"]intValue];
    if([dict objectForKey:@"rooms"])
    _RoomsCount=[[dict objectForKey:@"rooms"]intValue];
    _price=[[dict objectForKey:@"price"]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if(_price==nil)
        _price=@"Preis auf Anfrage";
    _status=[dict objectForKey:@"status"];
    _title=[dict objectForKey:@"title"];
}
return self;
}

@end
