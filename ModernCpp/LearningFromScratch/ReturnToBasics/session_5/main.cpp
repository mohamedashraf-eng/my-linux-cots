/**
 * @file main.cpp
 * 
 * @brief Modern C++ - Project
 * 
 * @details
 *      
**/
#include <iostream>
#include <string>
#include <vector>

// Class user to store user data and to be generic to inherit from.
// As user can be student, employee, intern, etc.
//
class User {
private:
    std::string m_name;
    // As age always positive and probably won't exceed 100.
    uint8_t m_age;
    // User id is string for flexibility
    std::string m_userid; 
    // Private method to generate a unique user id.
    // Better to use uuid technique.
    static std::string __generate_unique_userid(void) {
        static uint16_t _x = 0;
        return "mowx_" + std::to_string(_x++);
    }
public:
    User(const std::string& name, uint8_t age) : m_name(name), m_age(age) { m_userid = __generate_unique_userid(); }
    
    bool display_user_data_by_userid(const std::string& userid) const {
        if(userid == m_userid) {
            std::cout << "Name: " << m_name << "\n";
            std::cout << "Age: " << m_age << "\n";
            return true;
        }
        return false;
    }

    std::string get_userid() const {
        return m_userid;
    }
};

// Database class
class RegistryDatabaseSingleton {
private:
    // Vector of users to store @db
    std::vector<User> m_users;

public:
    RegistryDatabaseSingleton() {}
    
    void add_user(const User& user) {
        m_users.push_back(user);
        std::cout << "Done adding new user to the database. \n";
    }
    
    void display_user_data_by_userid(const std::string& userid) const {
        bool status = false;
        std::cout << "Searching database for userid: " << userid << "\n";
        for (const auto& user : m_users) {
            if (user.display_user_data_by_userid(userid)) {
                status = true;
                break;
            }
        }

        if (!status) {
            std::cout << "User not found in the registry. \n";
        }
    }

    bool is_empty() const {
        return m_users.empty(); 
    }
};

User create_new_user(const std::string& name, uint8_t age) {
    return User(name, age);
}

// Handle the user input 
enum class user_input_menu_option_enum {
    MENU_OPTION_ADD_RECORD   = 1,
    MENU_OPTION_FETCH_RECORD,
    MENU_OPTION_QUIT,
    MENU_OPTION_NA = -1
};

std::istream& operator>> (std::istream& input_stream, user_input_menu_option_enum& user_input) {
    int user_input_as_int = 0;
    input_stream >> user_input_as_int;
    user_input = static_cast<user_input_menu_option_enum>(user_input_as_int);
    return input_stream;
}

// The singleton database registery
static RegistryDatabaseSingleton db;

void add_record(std::string name="mowx", uint8_t age=0) {
    
}

bool switch_on_user_input_menu_options(user_input_menu_option_enum user_input, bool* cli_status) {
    // Error handle
    bool status = true;
    // Switch
    switch(user_input) {
        case user_input_menu_option_enum::MENU_OPTION_ADD_RECORD: {
            std::string name;
            uint8_t age;
            std::cout << "Enter name: ";
            std::cin.ignore(); // To ignore the newline character left in the buffer
            std::getline(std::cin, name); // Use getline to read the whole line for the name
            std::cout << "Enter age: ";
            std::cin >> age;

            User new_user = create_new_user(name, age);
            db.add_user(new_user); 
            break;
        }
        case user_input_menu_option_enum::MENU_OPTION_FETCH_RECORD: {
            if (db.is_empty()) {
                std::cout << "Error: No records found.\n";
                status = false;
            } else {
                std::string userid;
                std::cout << "Enter user id: ";
                std::cin >> userid;
                db.display_user_data_by_userid(userid);
            }
            break;
        }
        case user_input_menu_option_enum::MENU_OPTION_QUIT: {
            *cli_status = false;
            break;
        }

        default: 
            status = false;
            break;
    }
    return status;
}

void display_menu() {
    std::cout << "Please select an option: \n";
    std::cout << "1: Add record\n";
    std::cout << "2: Fetch record\n";
    std::cout << "3: Quit\n";
}

user_input_menu_option_enum get_user_input() {
    user_input_menu_option_enum user_input = user_input_menu_option_enum::MENU_OPTION_NA;
    std::cout << "[>]: ";
    std::cin >> user_input;
    return user_input;
}

bool main_app_loop() {
    bool cli_alive = true;
    bool app_status = true;

    while (cli_alive) {
        display_menu();
        user_input_menu_option_enum user_input = get_user_input();
        if (!switch_on_user_input_menu_options(user_input, &cli_alive)) {
            std::cout << "Invalid input. Please try again.\n";
        }
    }
    return app_status;
}

int main() {

    main_app_loop();

#if defined(TEST)
    _test();
#endif /* TEST */

    return 0;
}

void _test(void) {
    RegistryDatabaseSingleton test_db;

    // PRE
    for(uint8_t i = 0; i < 100; ++i) {
        test_db.add_user(create_new_user(std::string{"Mohamed"}, i));
    }
    
    // GROUP() - CASE()

    // GROUP() - CASE()

    // TEARDOWN
}
