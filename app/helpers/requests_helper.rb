module RequestsHelper

def request_image(request)
  image_tag(request.image)
end

def request_text(request)
  request.text
end

end
