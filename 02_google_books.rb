require 'rest-client'
require 'json'
require 'pry'

def query(user_input)
  user_input.gsub(" ", "+")
end

def response(query)
  url = "https://www.googleapis.com/books/v1/volumes?q=#{query}"
  RestClient.get(url)
end

def books(query)
  data = JSON.parse( response(query) )
  if data["items"]
    data["items"]
  else
    []
  end
end

def title(book)
  book["volumeInfo"]["title"]
end

def authors(book)
  authors = book["volumeInfo"]["authors"]
  if authors.length > 2
    authors.join(", ")
  else
    authors.join(" and ")
  end
end

def description(book)
  book["volumeInfo"]["description"]
end

def retail_price(book)
  if book["saleInfo"]["retailPrice"]
    book["saleInfo"]["retailPrice"]["amount"]
  else
    'Not For Sale'
  end
end

puts "Enter Query"
user_input = gets.chomp
query = query(user_input)
books = books(query)

books.each.with_index(1) do | book, index|
  puts "#{index}. #{title(book)}"
  puts "   by #{authors(book)}"
  puts "Retail Price: $ #{retail_price(book)}"
end

# I'd like to print out a list of books about Ruby Programming
### I'd like to print out the title of each book
### The author or authors of each book
### The Retail Price of each book
### Description
