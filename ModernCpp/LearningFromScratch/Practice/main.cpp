//! Learning multiple principles in modern C++
//! @author Mohamed Ashraf
//
//! Used to import stadnard (cout, cin)
#include <iostream>
//! Used to import standard (try, throw, catch, except)
#include <stdexcept>
//! Used to import STL (vector)
#include <vector>

//! Using default function argument value.
//! Using template to meta-program this function @ compile-time
template <typename T>
void apply_on__ranged_for_loop(bool actiavte_this = false) {
    if(actiavte_this) {
        std::cout << "[1] Practice on ranged for loop to print vector elements. \n";
        //
        //! Initalization:
        //      1. using () > set direct @ init.
        //      2. using {} > set value @ init. called uniform initialization (best-practice)
        //      3. using =  > Copy @ init.
        //      4. Default initialization done by compiler. (like std::string or classes-type)
        std::vector<T> my_vector {1, 2, 3, 4, 5, 6};
        //! Method one get the element by reference automatic to its data type 
        // Best practice
        std::cout << "Using reference: \n";
        for(auto& element : my_vector) {
            std::cout << "Element: " << static_cast<int>(element) << "\n";
        }
        //! Method two get the element as copy and print it with its datatype 
        std::cout << "Using copy: \n";
        for(uint8_t element : my_vector) {
            std::cout << "Element: " << static_cast<int>(element) << "\n";
        }
    } else {
        std::cout << "[1] Not active. \n";
    }
}

//! Sturcts in C++ are a public class.
//! It could be used as normal C-Style structs but can add inital values for the members.
//! And also could be used as C++ classes by adding a ctor and functions.
struct my_struct_parent {
    //! Default value
    int m_member = 4;
    //! Methods
    void print_member() {
        std::cout << "Member: " << m_member << "\n";
    }
    //! Default constructor.
    //! Constructor for the struct
    my_struct_parent() {};
};

struct my_struct_child : public my_struct_parent {
    //! Default value
    int m_member = 2;
    //! Methods
    void print_member() {
        std::cout << "Member: " << m_member << "\n";
    }
    //! Default constructor.
    //! Constructor for the struct
    my_struct_child() {};
};

//! Enums in C++ could be used as C-Style enums or as enum class.
//! Which defines a group.

//! Could be defined as type:
//! enum my_normal_enum x = X_OK;
enum my_normal_enum {
    X_OK = 0,
    X_NOK = ~X_OK
};
// sizeof(my_class_enum) => int
//! Could be defined but the access is grouped using scope resolution:
//! my_class_enum y = my_class_enum::Y_OK;
//! Could be size limited.
enum class my_class_enum : uint8_t {
    Y_OK = 0,
    Y_NOK
};
// sizeof(my_class_enum) => uint8_t

//! Classes in C++.
//! Everything is a class.
//      as example projkect of Classes we can create ATM backend system
//      ATM Components
//      LCD -> Object as class
//      Keypad -> Object as class
//      Scanner -> Object as class
//      Database -> Object as class
//      Transactions -> Object as class
//      By creating a relational class diagrams we can see the relations between the objects.
//      And clarify the responsibilities of each object.
class ATM {
private:
    //! Private members
    // LCD, Keypad, Scanner, Database, Transactions classes.
public:
    //! Public methods
    // ATM abstract methods.
};
//! Creating a private field group (namespace)
namespace db {
    //! Basic test class for class operations
    //! Rule of Zero: 
    //! If a class doesn't manage resources, rely on compiler-generated special member functions.
    //! Rule of Three: 
    //! If a class needs a custom destructor, copy constructor, or copy assignment operator, it likely needs all three.
    //! Rule of Five: 
    //! If a class needs a custom destructor, copy constructor, or copy assignment operator, 
    //! it likely also needs a custom move constructor and move assignment operator.
    class Data {
    private:
        std::string m_data {""};
        //! Giving your firend the access to your home private rooms
        //! In this case the compiler will premit the function <data_class_friend_func>
        //! to access the private members of the class without errors.
        //! This is called friend function.
        friend void data_class_friend_func(void);

    public:
        //! Class ctor
        //! Constructor delegation
        //! Used to "DRY".
        Data() : Data("") {};
        //! Overloading class ctor
        Data(const std::string& data) : m_data(data) { std::cout << '@' << this << ": " << *this << "\n"; };
        //! Copy constructor
        //! Used to clarify the copying mechanism for the class
        //! Shallow copy vs. Deep copy:
        //! - Shallow copy: Copying without considering critical resources.
        //!   - Copies the member variables as they are.
        //!   - May lead to issues if the class owns resources like raw pointers.
        //! - Deep copy: Copying with attention to owned resources.
        //!   - Involves duplicating resources such as dynamically allocated memory.
        //!   - Ensures each copy owns its own separate instance of resources.
        //! In this example, `std::string` is used, which manages its memory. Thus, the copy constructor
        //! performs a deep copy of the string's content automatically.
        //! Note: to run copy constructor normally: compile with CXX_FLAG `-fno-elide-constructors` 
        Data(const Data& data) : m_data(data.m_data) {
            //! Doing operation
            std::cout << "Copy constructor called.\n";
            //! Handle any critical cases
        };
        //! Move constructor
        //! Used to clarify the rvalue assignation moving mechanism for the class.
        Data(Data&& temp) {
            std::cout << "Move constructor called.\n";
            //! Move the string using string class move constructor
            m_data = std::move(temp.m_data);
            //! Handle any critical cases
        }

        //! Public Class methods prototype (forward declaration)
        std::string get_data();
        void set_data(const std::string& data);
        void print_data(void);

        //! Overloading operator to handle the class cases
        //! Overloading the '+' operator to handle the class cases.
        //      Note that "operator" is a C++ keyword that supports for the operator overloading.
        //! Now if we called `std::string result = db::Data + std::string {"String"};`
        //! The compiler will call the `operator+` overloadded function and will return the result.
        Data& operator+ (std::string& passed_str) {
            //! Doing operation
            std::string temp = m_data + passed_str;
            //! Returning the result as the value pointed by the self pointer which is the current class reference.
            return *this;
        };

        //! Overloading insertion operator with ostream `<<`
        //! Tells the ostream to tread the class in a special way.
        //! The `friend` operator is used to declare this method as a friend of the class to access the private members.
        //! This is called a friend function. 
        friend std::ostream& operator<< (std::ostream& os, Data& data) {
            //! Doing operation
            //      Inserting the data into the ostream buffer.
            os << data.m_data;
            //! Returnning the newly output buffer stream
            return os;
        };

        //! Handle the copy assignment operator
        Data& operator= (const Data& data) {
            //! Detect if the current object is the same as the passed object
            if(this == &data) {
                //! Return the class self pointer
                return *this;
            } 
            //! Else handle it by deep copy mechanism
        };

        //! Overload class functor
        void operator() (void) const {
            //! Doing operation
            //      Unimplmented.
            std::cout << "This is a class functor. \n";
        };

        //! Overloading class destructor
        //! Class dtor
        //! Default constructor type `default`.
        //      Basically tells the compiler to generate this method ABI.
        ~Data() = default;
    };
    //! Implementing the class methods outside the class by scope resolution it 
    //! to the reference class
    std::string Data::get_data() {
        return m_data;
    }
    void Data::set_data(const std::string& data) {
        m_data = data;
    }
    void Data::print_data(void) {
        std::cout << "Data: " << m_data << "\n";
    }
    //! A friend function to access the private members of the class.
    void data_class_friend_func(void) {
        std::string friend_string {"Friend"};
        Data data_from_a_friend(friend_string);
        data_from_a_friend.m_data = "Hello Mohamed Ashraf from a friend";
        data_from_a_friend.print_data();
    }
};
//! Similiar to C typedef converting (aliasing) a variable to another name,
//! with the same definition.
using Data_t = db::Data;

int main(void) {
    //! 
    apply_on__ranged_for_loop<uint8_t>();
    //!
    //!
    //!
    //! Testing class
    std::string my_secret_data {"Mohamed Ashraf"};
    Data_t my_data_class(my_secret_data);
    my_data_class.print_data();
    my_data_class();
    //!
    //! Test the class friend function
    db::data_class_friend_func();

    return 0;
}