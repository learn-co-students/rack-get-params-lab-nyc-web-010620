class Application

    @@items = ["Apples","Carrots","Pears"]
    @@cart =["Apples", "Carrots"]
  
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      if req.path.match(/items/)
        @@items.each do |item|
          resp.write "#{item}\n"
        end 
      elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)
      else
        resp.write "Path Not Found"
      end
  
      if req.path.match(/cart/)
        @@cart.each do |cart|
          resp.write "#{cart}\n"
        end
      elsif req.path.match(/add/)
        add_item = req.params["item"]
        resp.write handle_add(add_item)
      else
        resp.write "Your cart is empty"
      end
  
      resp.finish
    end
    end
  
    def handle_search(search_term)
      if @@items.include?(search_term)
        return "#{search_term} is one of our items"
      else
        return "Couldn't find #{search_term}"
      end
    end
  
    def handle_add(add_item)
      if @@items.include?(add_item)
        return @@cart<< add_item
      else
        return "We don't have that item"
      end
    end
  
  
  