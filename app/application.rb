require 'pry'

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

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
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      search_term = req.params["item"]

      if @@items.include?(search_term)
        @@cart << search_term
        resp.write "added Figs"
      else 
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end
    # binding.pry
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end


# ohh 
# so you have a response and a request from this

# search_term = req.params["item"]
# this is acts a hash has a key and a value
# '/add?item=Figs' <- from the rspec/ How it looks like on the browser