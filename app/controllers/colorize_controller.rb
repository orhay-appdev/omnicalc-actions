class ColorizeController < ApplicationController
  def colorize
    input = {
      image: params.fetch("image_url")
    }

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    @original_image_url = params.fetch("image_url")
    input = @original_image_url
    client = Algorithmia.client('simbxe1zOTxjCwlDye3lRtytCzw1')
    algo = client.algo('deeplearning/ColorfulImageColorization/1.1.13')
    result = algo.pipe(input).result
    pic = result['output']
    pic = pic.gsub("data://","https://algorithmia.com/v1/data/")
    @colorized_image_url = pic

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("colorize_templates/colorize.html.erb")
  end

  def colorize_form
    render("colorize_templates/colorize_form.html.erb")
  end
end
