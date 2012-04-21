nextbusjs = require 'nextbusjs'
rutgers = nextbusjs.client()
flatiron = require 'flatiron'

app = flatiron.app
app.use flatiron.plugins.http

app.router.get '/', (req, res) ->
  res.send 'hello'

app.router.get '/route/:route', (route) ->
  rutgers.routePredict route, null, ((err, data) =>
    if err
      @res.writeHead 500, 'Content-Type': 'application/json'
      @res.end JSON.stringify err
      return
    @res.writeHead 200, 'Content-Type': 'application/json'
    @res.end JSON.stringify data
  ), 'both'

app.router.get '/stop/:stop', (stop) ->
  rutgers.stopPredict stop, null, ((err, data) =>
    if err
      @res.writehead 500, 'content-type': 'application/json'
      @res.end json.stringify err
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
      @res.end json.stringify err
      return
    @res.writeHead 200, 'Content-Type': 'application/json'
    @res.end JSON.stringify data
  ), true

setInterval (->
  rutgers.guessActive ->
), 120000

rutgers.cacheAgency 'rutgers', (err) ->
  if err then return console.dir err
  rutgers.guessActive ->
    console.log 'listening'
    app.start 3000

