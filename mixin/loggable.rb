module Loggable

  def log(title,e)
    if Application.environment.to_s == "development" ||
       Application.environment.to_s == "test"

      puts "~~ #{title} ~~"
      return
    end

    puts "\n"
    puts "----------------------------------------------------------------\n"
    puts "#{title}\n"
    puts "----------------------------------------------------------------\n"
    puts "\n"
    puts e.message
    puts e.backtrace.join("\n")
    puts "\n"
    puts "----------------------------------------------------------------\n"
    puts "\n"
  end

end
