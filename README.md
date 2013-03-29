# Sugabus
This is an extremely simple wrapper API around [nextbusjs](https://github.com/russfrank/nextbusjs)
for people who don't want to use javascript.  It is currently hosted on
nodejitsu.

The base URL is: runextbus.heroku.com

<table class="table">                                                          
   <thead>                                                                      
      <tr>                                                                      
         <th>URL</th>                                                           
         <th>Parameters</th>                                                    
         <th>Description</th>                                                   
      </tr>                                                                     
   </thead>                                                                     
   <tr>                                                                         
      <td>/route/$ROUTE</td>                                                    
      <td>$ROUTE is a route tag</td>                                            
      <td>List of predictions for the requested route</td>                      
   <tr>                                                                         
      <td>/stop/$STOP</td>                                                      
      <td>$STOP is a stop tag OR stop title</td>                                
      <td>List of predictions for the requested stop</td>                       
   <tr>                                                                         
      <td>/active</td>                                                          
      <td></td>                                                                 
      <td>List of active routes and stops (ie, buses are running)</td>          
   </tr>                                                                        
   <tr>                                                                         
      <td>/nearby/$LAT/$LON</td>                                                
      <td>$LAT and $LON are latitude and longitutde</td>                        
      <td>Nearby stops to the given lat lon</td>                                
   </tr>                                                                        
   <tr>                                                                         
      <td>/locations</td>                                                       
      <td></td>                                                                 
      <td>Vehicle locations.  This always gets the vehicles which have moved in the last 15 minutes.</td>
   </tr>                                                                        
   <tr>                                                                         
      <td>/config</td>                                                          
      <td></td>                                                                 
      <td>Retrieves the 'agency cache'.  This contains a list of all routes and stops, as well as a sorted
      array of routes and stops for display in the app.</td>                    
   </tr>     
</table>


