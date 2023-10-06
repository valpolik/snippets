# config.ru example for rackup for rack.


class Mid1
  def initialize(app)
    @app = app
    p("Mid1 *** initialize *** @app :             #{@app}")
  end

  def call(env)
    env[1] ||= []
    env[1] << "++ from Mid1"
    p("Mid1")
    @app.call(env)
    # [200, {}, ["#{p(env)}"]]
  end
end




class Mid2
  def initialize(app)
    @app = app
    p("Mid2 *** initialize *** @app :             #{@app}")
  end

  def call(env)
    env[1] ||= []
    env[1] << "++ from Mid2"
    p("Mid2")
    @app.call(env)
    # [200, {}, ["#{p(env)}"]]
  end
end





class App
  def self.call(env)
    env[1] ||= []
    env[1] << "++ from App"
    p("App")
    # pp(env)

    puts
    puts
    puts

    # All rack middleware, included internal rack middleware:
    # Rack::ContentLength
    # Rack::CommonLogger
    # Rack::ShowExceptions
    # Rack::Lint
    # Rack::TempfileReaper
    p(env["puma.config"].options.user_options[:app])

    puts
    puts
    puts

    [200, {}, ["#{p(env)}"]]
  end
end




use Mid1
use Mid2
run App
