require("sinatra")
require('sinatra/contrib/all')
require('pry-byebug')

require_relative("models/student")
also_reload("models/*")

# Student.delete_all()

get("/hogwarts") do
  @students= Student.all()
  erb(:index)
end

get("/hogwarts/new") do
  @houses= House.all()
  erb(:new)
end

post("/hogwarts") do
  @student= Student.new(params)
  @houses= House.all()
  @house= @houses.find{|house| house.name== params[:house_name]}
  @student= Student.new()
  @student.save()
  erb(:create)
end

get("/hogwarts/:id") do
  @student= Student.find_by_id(params[:id])
  @house= House.find_by_id(@student.house_name)
  erb(:show)
end

get("/hogwarts/:id/edit") do
  @student= Student.find_by_id(params[:id])
  @houses= House.all()
  erb(:edit)
end

post("/hogwarts/:id") do
  @student= Student.new(params)
  @student.update()
  erb(:update)
end

get("/hogwarts/:id/delete") do
  Student.delete_by_id(params[:id])
  erb(:destroy)
end
