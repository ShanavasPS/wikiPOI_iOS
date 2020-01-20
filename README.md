# wikiPOI

A simple iOS application to fetch the current location of the device and get nearby
English language Wikipedia articles.

Build Instructions
```
Download or clone the repository
Go to the repository folder and run 'pod install'
Open the xc workspace file.
```

Development Environment
```
MacOS Mojave 10.14.6
XCode 11.3
```

Tested Devices
```
iPhone SE - iOS 12.1.2
iPhone X - iOS 13.3
```

Pods used
```
Apollo - GraphQl client
Polyline 
RxCoreLocation
RxMKMapView
RxSwift
RxCocoa
```

Workflow
```
The nearby articles are shown on the map as a point of interest (POI) based on the current location. 

On particular POI selection, application popups up a detail view with the map centered on the selected POI. 

Article detail shows title, images (if any), description and link to wiki article. 

On clicking "Get Suggested routes", Application gives route suggestions to the user, how to reach selected POI. 

On selecting any of the suggested routes, application shows direction from the current location to the selected POI. Also, only the selected POI is shown at this stage.

On selecting the map, the routes are removed and all the previous pois are populated again.

```

Apollo

```
Decided to go with the "https://digitransit.fi/en/developers/apis/1-routing-api/routes/" API,
instead of the Google Directions API, as I thought it would be best to get information form digitranstit,
which seemed to have more detailed route information.

Hence I had to install the Apollo client for GraphQl.
Refer for more info : https://www.apollographql.com/docs/ios/installation/
```

Polyline

```
Polyline was used to create the route overlay based on the google encoded polyline receieved from the digitransit server.

Initially I tried to calculate the polyline using the built in MKDirections, but polylines it created did not made sense at times. So, instead used the geometry received from digitransit and converted it to MKPolyline.

Different transit modes are displayed in different color to easily distinguish between them.

```

POI Details

```
The wiki API for fetching the poi details did not gave the urls to the POI 
and the API which I used to fetch the image urls did not gave the POI description.
So I had to call two APIs to fetch the details of a selected POI.

Also, I have only tried to display the jpg images and ignored the svg images for the POI.

```
