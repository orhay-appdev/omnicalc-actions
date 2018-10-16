class LoanPaymentController < ApplicationController
  def loan_payment
    @apr = params.fetch("annual_percentage_rate").to_f #r
    @years = params.fetch("number_of_years").to_i #N
    @principal = params.fetch("principal_value").to_f #P

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    r = (@apr/12.0)
    r = r/100
    
    p_ = @principal
    
    nn = @years*12
    
    @monthly_payment = (r*p_)/(1-(1+r)**(-nn))
   

    render("loan_payment_templates/loan_payment.html.erb")
  end

  def loan_payment_form
    render("loan_payment_templates/loan_payment_form.html.erb")
  end
end
