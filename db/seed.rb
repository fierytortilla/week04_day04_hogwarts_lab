require_relative("../models/student")
require_relative("../models/house")
require("pry-byebug")

Student.delete_all()
House.delete_all()

house1= House.new({'name' => "Gryffindor"})
house2= House.new({'name' => "Hufflepuff"})
house3= House.new({'name' => "Ravenclaw"})
house4= House.new({'name' => "Slytherin"})

house1.save()
house2.save()
house3.save()
house4.save()

student1= Student.new({'first_name'=>"Ebony", 'last_name'=>"Dementia-Way-Raven", 'age'=>17, 'house_name'=>house4.id})

student1.save()

student2= Student.new({'first_name'=>"Nick", 'last_name'=>"Cave", 'age'=>20, 'house_name'=>house3.id})

student2.save()

student3= Student.new({'first_name'=>"Stephen", 'last_name'=>"Watson", 'age'=>25, 'house_name'=>house1.id})

student3.save()

student4 = Student.new({'first_name'=>"Edward", 'last_name'=>"Snowden", 'age'=>41, 'house_name'=>house2.id})

student4.save()

houses= House.all()

binding.pry()

nil
