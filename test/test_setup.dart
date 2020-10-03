import 'package:ikechukwu_israel/models/csv.dart';

class Setup {
  static loadCsv() {
    List<Csv> list = [];
    list.add(
      Csv(
        first_name: 'John',
        last_name: 'Smith',
        email: 'john@example.com',
        car_color: 'Green', 
        car_model_year: 2000,
        car_model: 'Lincoln',
        gender: '',
        job_title: 'Accountant',
        country: 'USA', 
        bio: 'lorem ipsum da la estuid'
      ),
    );
    list.add(
      Csv(
        first_name: 'John',
        last_name: 'Smith',
        email: 'john@example.com',
        car_color: 'Green', 
        car_model_year: 2000,
        car_model: 'Lincoln',
        gender: '',
        job_title: 'Accountant',
        country: 'USA', 
        bio: 'lorem ipsum da la estuid'
      ),
    );
    list.add(
      Csv(
        first_name: 'John',
        last_name: 'Smith',
        email: 'john@example.com',
        car_color: 'Green', 
        car_model_year: 2000,
        car_model: 'Lincoln',
        gender: '',
        job_title: 'Accountant',
        country: 'USA', 
        bio: 'lorem ipsum da la estuid'
      ),
    );
    list.add(
      Csv(
        first_name: 'Mariam',
        last_name: 'Ague',
        email: 'miriam@example.com',
        car_color: 'Yellow', 
        car_model_year: 1996,
        car_model: 'Lincoln',
        gender: 'Male',
        job_title: 'Accountant',
        country: 'USA', 
        bio: 'lorem ipsum da la estuid'
      ),
    );
    list.add(
      Csv(
        first_name: 'Daniel',
        last_name: 'Max',
        email: 'max@example.com',
        car_color: 'Green', 
        car_model_year: 2000,
        car_model: 'Wagon',
        gender: '',
        job_title: 'Accountant',
        country: 'Netherland', 
        bio: 'lorem ipsum da la estuid'
      ),
    );
    list.add(
      Csv(
        first_name: 'Max',
        last_name: 'Smith',
        email: 'smith@example.com',
        car_color: 'Teal', 
        car_model_year: 2000,
        car_model: 'Lincoln',
        gender: '',
        job_title: 'Accountant',
        country: 'USA', 
        bio: 'lorem ipsum da la estuid'
      ),
    );
    return list;
  }
}
