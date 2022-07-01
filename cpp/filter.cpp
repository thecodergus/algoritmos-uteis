#include <functional>
#include <algorithm>

using namespace std;

auto aboveEighty = [](Student student)
{ return student.score() > 80; };
vector<Student> topStudents = {};
auto it = std::copy_if(students.begin(), students.end(), back_inserter(topStudents), aboveEighty);
std::for_each(topStudents.begin(), topStudents.end(), printStudentDetails);