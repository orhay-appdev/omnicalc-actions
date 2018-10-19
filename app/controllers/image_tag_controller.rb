class ImageTagController < ApplicationController
  def image_tag
    input = {
      image: params.fetch("image_url")
    }

    # ================================================================================
    # Your code goes below.
    # ================================================================================

    @original_image_url = params.fetch("image_url")
    input = @original_image_url
    client = Algorithmia.client('simbxe1zOTxjCwlDye3lRtytCzw1')
    algo = client.algo('deeplearning/IllustrationTagger/0.4.0')
    result = algo.pipe(input).result
    @tag_hashes = result

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("image_tag_templates/image_tag.html.erb")
  end

  def image_tag_form
    render("image_tag_templates/image_tag_form.html.erb")
  end
end
