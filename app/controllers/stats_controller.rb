class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length
    minimum = @numbers[0]
    @numbers.each do |num|        
     if num < minimum
       minimum = num
     end
   end
    @minimum = minimum
    
    maximum = minimum
    @numbers.each do |num|        
  if num > maximum
    maximum = num
  end
end
    @maximum = maximum

    @range = maximum-minimum

    # Median
    # ======
    sorted = @numbers.sort
    len = sorted.length
    median = (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    @median = median
    
    sum = 0
    @numbers.each do |num|        
    sum = sum + num
    end
    @sum = sum

    @mean = @sum/@count

    # Variance
    # ========
    sum = 0
    @numbers.each do |num|
      sum += (num-@mean)**2
    end
     
    @variance = sum/@count

    @standard_deviation = @variance**0.5

    # Mode
    # ====
    myarray = Hash.new(0)
    @numbers.each do |num|
      myarray[num] += 1
      end
    @mode = myarray.key(myarray.values.max)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end
