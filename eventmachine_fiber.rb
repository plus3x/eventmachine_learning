require "eventmachine"
require "fiber"

def value
  current_fiber = Fiber.current

  EM.add_timer(2) do
    puts "B"
    current_fiber.resume("D") # Wakes the fiber
  end

  Fiber.yield # Suspends the Fiber, and returns "D" after #resume is called
end

EM.run do
  Fiber.new {
    puts "A"
    val = value
    puts "C"
    puts val

    EM.stop
  }.resume

  puts "(Async stuff happening)"
end