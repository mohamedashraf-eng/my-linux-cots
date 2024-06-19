/**
 * @file main.cpp
 * 
 * @brief Modern C++ - Classes & Enums
 * 
 * @details
 *      
**/
#include <iostream>

class arth_operations {
private:
    int8_t m_var1;
    int8_t m_var2;
public:
    arth_operations(int8_t& var1, int8_t& var2) : m_var1(var1), m_var2(var2) { }

    int16_t sum(void) const noexcept {
        return (this->m_var1 + this->m_var2);
    }

    int16_t sub(void) const noexcept {
        return (this->m_var1 - this->m_var2);
    }

    int16_t mul(void) const noexcept {
        return (this->m_var1 * this->m_var2);
    }

    int16_t div(void) const noexcept {
        return (this->m_var1 / this->m_var2);
    }
};

enum class arth_operations_enum {
    AOP_OP_ADD,
    AOP_OP_SUB,
    AOP_OP_MUL,
    AOP_OP_DIV,
};

enum class arth_operations_error {
    AOP_E_DIV_BY_ZERO,
    AOP_E_OVERFLOW,
    AOP_E_UNDERFLOW
};

// Extractor operator overload
// Used to define a new input stream data type for the created enum data type
// General form: std::istream& operator>> (std::istream& input_stream, enum_data_type& x)
//
std::istream& operator>> (std::istream& input_stream, arth_operations_enum& option_as_enum) {
    // Define the default defined type
    int option_as_int = 0;
    // Take it by the input stream
    input_stream >> option_as_int;
    // Convert it to the desired type by using static cast (compile-time detection cast)
    option_as_enum = static_cast<arth_operations_enum>(option_as_int);
    // Return the input stream to overwrite the base input stream
    return input_stream;
}

int main(void) {
    int8_t a = 5;
    int8_t b = 6;

    arth_operations new_op(a, b);

    arth_operations_enum option;

    std::cout << "[>]: ";
    std::cin >> option;

    switch(option) {
        case arth_operations_enum::AOP_OP_ADD : {
            std::cout << "sum = " << new_op.sum() << "\n";
            break;
        } 
        case arth_operations_enum::AOP_OP_SUB : {
            std::cout << "sub = " << new_op.sub() << "\n";
            break;
        } 
        case arth_operations_enum::AOP_OP_MUL : {
            std::cout << "mul = " << new_op.mul() << "\n";
            break;
        } 
        case arth_operations_enum::AOP_OP_DIV : {
            std::cout << "div = " << new_op.div() << "\n";
            break;
        } 
        default: {
            std::cout << "Invalid option\n";
        }
    }

    return 0;
}