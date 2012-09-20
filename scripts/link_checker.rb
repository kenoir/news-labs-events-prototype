module LinkChecker 
  require 'rest_client'
  require 'json'
  require 'colorize'

  class Checker

    def rest_proxy
      ENV['REST_PROXY'] 
    end

    def juicer_api_url
      'http://juicer.responsivenews.co.uk/events'
    end

    def app_event_base_uri
      'http://news-labs-events-prototype.herokuapp.com/event/'
    end

    def all_available_events
      RestClient.proxy = rest_proxy 
      response = RestClient.get juicer_api_url, :accept => 'application/json'

      events_json = response.to_str
      parsed_events_json = JSON.parse(events_json)

      parsed_events_json
    end

    def get_events(events)
      RestClient.proxy = ENV['REST_PROXY']

      responses = Array.new

      events.each do | event |
        event_uri = "#{app_event_base_uri}#{event["id"].to_s}"

        response = { 
          :title => event["title"], 
          :id => event["id"],
          :time => nil,
          :success => true
        }

        begin
          start_time = Time.now
          RestClient.get event_uri
        rescue
          response[:success] = false;
        end

        response_time = Time.now - start_time
        response[:time] = response_time

        output = "Response: #{response.inspect}"

        if response[:success]
          puts output.green
        else
          puts output.red
        end

        responses.push(response)
      end

      responses
    end

  end

  def self.all_ok?
    checker = Checker.new 

    events = checker.all_available_events
    responses = checker.get_events(events)

    puts "\n"
    puts "\n"
    puts "-----------------------------\n"
    puts "     LinkChecker Summary     \n"
    puts "-----------------------------\n"
    puts "\n"
    all_succeeded = true
    responses.each do | response |
      if not response[:success]
        all_succeeded = false
        puts "Failed: #{response.inspect}".red
      end
    end
    if all_succeeded
      puts "None failed!".green
    end

    all_succeeded
  end

end
