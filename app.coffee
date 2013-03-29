nextbusjs = require 'nextbusjs'
rutgers = nextbusjs.client()
flatiron = require 'flatiron'
request = require 'request'

app = flatiron.app
app.use flatiron.plugins.http

app.router.get '/', (req, res) ->
  @res.writeHead 200, 'Content-Type': 'application/json'
  @res.end 'Docs available at: api.rutgers.edu'

app.router.get '/route/:route', (route) ->
  rutgers.routePredict route, null, ((err, data) =>
    if err
      @res.writeHead 500, 'Content-Type': 'application/json'
      @res.end JSON.stringify err
      return
    @res.writeHead 200, 'Content-Type': 'application/json'
    @res.end JSON.stringify data
  ), 'both'

app.router.get /\/stop\/(.*)/, (stop) ->
  stop = stop.replace /%20/g, ' '
  rutgers.stopPredict stop, null, ((err, data) =>
    if err
      @res.writeHead 500, 'content-type': 'application/json'
      @res.end JSON.stringify err
      return
    @res.writeHead 200, 'Content-Type': 'application/json'
    @res.end JSON.stringify data
  ), 'both'

app.router.get '/active', ->
  @res.writeHead 200, 'Content-Type': 'application/json'
  @res.end JSON.stringify(rutgers.getAgencyCache().active)

app.router.get '/nearby/:lat/:lon', (lat, lon) ->
  stops = rutgers.closestStops lat, lon, 10
  @res.writeHead 200, 'Content-Type': 'application/json'
  @res.end JSON.stringify stops

app.router.get '/config', ->
  @res.writeHead 200, 'Content-Type': 'application/json'
  @res.end JSON.stringify rutgers.getAgencyCache()

app.router.get '/locations', ->
  rutgers.vehicleLocations null, ((err, data) =>
    if err
      @res.writehead 500, 'content-type': 'application/json'
      @res.end JSON.stringify err
      return
    @res.writeHead 200, 'Content-Type': 'application/json'
    @res.end JSON.stringify data
  ), true

setInterval (->
  rutgers.guessActive ->
), 120000

console.log 'grabbing route config'
request 'https://rumobile.rutgers.edu/0.1/rutgersrouteconfig.txt', (err, response, body) ->
  if err then return console.dir err
  rutgers.setAgencyCache (JSON.parse body), 'rutgers'
  rutgers.guessActive ->
    console.log 'listening port ' + process.env.PORT || 3000
    app.start process.env.PORT || 3000


