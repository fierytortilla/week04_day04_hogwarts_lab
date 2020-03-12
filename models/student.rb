require_relative('../db/sql_runner.rb')
require("pry-byebug")


class Student

  attr_reader :id
  attr_accessor :first_name, :last_name, :age, :house_name

  def initialize(options)
    @first_name= options['first_name']
    @last_name= options['last_name']
    @age= options['age'].to_i()
    @house_name= options['house_name'].to_i()
    @id= options['id'].to_i() if options['id']
  end

  def save()
    sql= "INSERT INTO students
          (first_name, last_name, age, house_name)
          VALUES ($1, $2, $3, $4)
          RETURNING id"
    values= [@first_name, @last_name, @age, @house_name]
    #binding.pry()
    result= SqlRunner.run(sql, values)
    @id= result[0]['id']
  end

  def self.all()
    sql= "SELECT * from students"
    results= SqlRunner.run(sql)
    return Student.map_out(results)
  end

  def self.find_by_id(id)
    sql= "SELECT * FROM students WHERE id=$1"
    values= [id]
    result= SqlRunner.run(sql, values)
    return Student.new(result[0])
  end

  def self.map_out(sqlResults)
    return sqlResults.map{|result| Student.new(result)}
  end

  def update()
    sql= "UPDATE students SET
          (first_name, last_name, age, house_name)
          = ($1, $2, $3, $4) WHERE id=$5"
    values= [@first_name, @last_name, @age, @house_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql= "DELETE FROM students"
    SqlRunner.run(sql)
  end

  def delete()
    sql= "DELETE FROM students WHERE id=$1"
    values= [@id]
    SqlRunner.run(sql, values)
  end

  def pretty_name()
    return @first_name+" "+@last_name
  end

  def self.delete_by_id(id)
    sql= "DELETE FROM students
    WHERE id = $1"
    values= [id]
    SqlRunner.run( sql, values )
  end

  def get_house()
    sql= "SELECT * FROM houses WHERE id = $1"
    values= [@id]
    result= SqlRunner.run(sql, values)
    return result[0]['name']
  end


end
