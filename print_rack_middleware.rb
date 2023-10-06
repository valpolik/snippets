require 'rack'

# get first middleware
app = Rack::Builder.parse_file('config.ru').first






# print and return all rack middleware
->(app) do
  arr = []

  loop do
    arr << app

    unless app.instance_variable_get(:@app)
      p(app.name)
      break
    end

    p(app.class.name)
    app = app.instance_variable_get(:@app)
  end

  arr
end
.call(app)





# return all rack middleware
->(app) do
  arr = []

  loop do
    arr << app
    app = app.instance_variable_get(:@app)
    break unless app
  end

  arr
end
.call(app)
