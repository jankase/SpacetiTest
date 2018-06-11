# Spaceit Example project

## Basic info

Single screen application with weather information. 
By default using user location to display weather information.
Besides information provided by app application calculate apparent
temperature and calculate wind direction in 16piece compass abbreviation.
Clicking on map marker detail info displayed. Detail info view can be dismissed by tapping on
detail view or by swipe down on detail view.

## Used technologies

The application using following 3<sup>rd</sup> party frameworks:

- Realm (store local data)
- Alamofire (download network data)
- SnapKit (autolayout DSL)
- Mapbox (maps)
- Material components (support for some basic UI components)

For processing JSON data is used built-in protocol `Codable` in Swift 4.

## Known issues

- sometimes click on map marker does not react
    - it happens to markers hidden during resize of map view during showing detail weather info
    - small move with map resolve issue
    - map delegate not invoked at all
- current location typically does not show weather info
    - API for providing weather info does not provided it
    - API for individual location using slightly different structure
