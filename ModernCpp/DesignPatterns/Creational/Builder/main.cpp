//! Learning Design Patterns CPP_GOF_Builder
//! @author Mohamed Ashraf
//
//! Used to import standard (cout, cin)
#include <iostream>
#include <array>
#include <vector>

//! Creational design patterns
// !The Builder pattern is a creational design pattern that provides a way to construct
// !a complex object step by step. It separates the construction of a complex object
// !from its representation, allowing the same construction process to create different representations.

// !The pattern involves four main components:
// !1. Product: The complex object that is being built. In this case, it's the Uart class.
// !2. Builder: An abstract interface that defines the construction steps. It's the IUartBuilder interface.
// !3. Concrete Builder: A class that implements the Builder interface to construct and assemble parts
// !   of the product. It's the UartBuilder class.
// !4. Director: A class that constructs the object using the Builder interface. It directs the
// !   construction process. It's the UartDirector class.

// !Usage of Builder Pattern:
// !- Define the product class (Uart) that contains the logic for the final product.
// !- Define an abstract Builder interface (IUartBuilder) that specifies the construction steps.
// !- Create one or more Concrete Builder classes (UartBuilder) that implement the Builder interface
// !  and provide specific implementations of the construction steps.
// !- Define a Director class (UartDirector) that manages the construction process using the Builder interface.
// !- The client code creates a Director object and a Concrete Builder object, sets the builder in the Director,
// !  and calls the construction process. The Director calls the builder's methods in a specific order to build the product.

// !Benefits of the Builder Pattern:
// !- It provides control over the construction process by separating the construction code from the representation code.
// !- It allows the creation of different representations of a product using the same construction process.
// !- It makes the construction process more flexible and reusable.

// !Example Scenario:
// !- Suppose we have a Uart class representing a UART peripheral with various configurations like baudrate, parity, and stop bits.
// !- We use the Builder pattern to construct the Uart object step by step, allowing different configurations to be created
// !  using the same construction process.


//! Uart class representing the product being built
template <std::size_t buffer_size>
class Uart {
private:
    std::array<uint8_t, buffer_size> m_buffer;
    uint32_t m_baudrate;
    uint8_t m_parity;
    uint8_t m_stop_bits;

public:
    Uart() : m_baudrate(9600), m_parity(0), m_stop_bits(1) {}

    void set_baudrate(uint32_t baudrate) {
        m_baudrate = baudrate;
    }

    void set_parity(uint8_t parity) {
        m_parity = parity;
    }

    void set_stop_bits(uint8_t stop_bits) {
        m_stop_bits = stop_bits;
    }

    void refresh_buffer() {
        std::cout << "Reading MCU UART peripheral buffer. \n";
        //! Read MCU UART peripheral buffer.
        //! Method: UART ISR
    }

    void show_config() {
        std::cout << "UART Configuration: \n";
        std::cout << "Baudrate: " << m_baudrate << "\n";
        std::cout << "Parity: " << static_cast<int>(m_parity) << "\n";
        std::cout << "Stop Bits: " << static_cast<int>(m_stop_bits) << "\n";
    }

    ~Uart() = default;
};

//! Builder interface
template <std::size_t buffer_size>
class IUartBuilder {
public:
    virtual ~IUartBuilder() = default;
    virtual IUartBuilder<buffer_size>& build_baudrate() = 0;
    virtual IUartBuilder<buffer_size>& build_parity() = 0;
    virtual IUartBuilder<buffer_size>& build_stop_bits() = 0;
    virtual Uart<buffer_size> get_uart() = 0;
};

//! Concrete Builder
template <std::size_t buffer_size>
class UartBuilder : public IUartBuilder<buffer_size> {
private:
    Uart<buffer_size> m_uart;

public:
    UartBuilder() = default;

    IUartBuilder<buffer_size>& build_baudrate() override {
        m_uart.set_baudrate(115200); 
        return *this;
    }

    IUartBuilder<buffer_size>& build_parity() override {
        m_uart.set_parity(1);
        return *this;
    }

    IUartBuilder<buffer_size>& build_stop_bits() override {
        m_uart.set_stop_bits(2); 
        return *this;
    }

    Uart<buffer_size> get_uart() override {
        return m_uart;
    }
};

//! Director class
template <std::size_t buffer_size>
class UartDirector {
private:
    IUartBuilder<buffer_size>* m_builder;

public:
    void set_builder(IUartBuilder<buffer_size>* builder) {
        m_builder = builder;
    }

    void construct_uart() {
        m_builder->build_baudrate().build_parity().build_stop_bits();
    }
};

int main() {
    //! System testing

    constexpr std::size_t buffer_size = 64;

    UartDirector<buffer_size> director;
    UartBuilder<buffer_size> builder;

    director.set_builder(&builder);
    director.construct_uart();

    Uart<buffer_size> uart = builder.get_uart();
    uart.show_config();

    return 0;
}
