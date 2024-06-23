#pragma once

#include <cstdint>
#include <array>
#include <stdexcept>

/**
 * @brief A circular buffer class template.
 * 
 * @tparam T The type of the elements stored in the buffer.
 * @tparam N The maximum size of the buffer.
 */
template <typename T, uint32_t N>
class circular_buffer {
private:
    /**
     * @brief The index of the head element in the buffer.
     */
    uint32_t m_head;

    /**
     * @brief The index of the tail element in the buffer.
     */
    uint32_t m_tail;

    /**
     * @brief The maximum size of the buffer.
     */
    uint32_t m_tsize;

    /**
     * @brief The current size of the buffer.
     */
    uint32_t m_csize;

    /**
     * @brief The container for the elements of the buffer.
     */
    std::array<T, N> m_container {0};

public:
    /**
     * @brief Constructs a circular buffer with a maximum size of N.
     */
    circular_buffer() noexcept : m_head(0), m_tail(0), m_tsize(N), m_csize(0) {};

    /**
     * @brief Constructs a circular buffer with a maximum size of N and initializes
     *        the buffer with the given values.
     * @param il_values The initializer list of values to initialize the buffer.
     * @throws std::runtime_error If the initializer list size is greater than N.
     */
    circular_buffer(const std::initializer_list<T>& il_values) : m_head(0), m_tail(0), m_tsize(N), m_csize(0) {
        if(il_values.size() > N) {
            throw std::runtime_error("Initializer list is too long.");
        }

        for(auto const& item : il_values) {
            push_back(item);
        }        
    };

    /**
     * @brief Pushes an element to the end of the buffer.
     * @param item The element to be added to the buffer.
     * @throws std::runtime_error If the buffer is full.
     */
    void push_back(T item) {
        if(m_tail >= N) {
            m_tail = 0;
        }
        if((m_head == m_tail) && (m_csize > 0)) {
            ++m_head;
            if(m_head >= N) {
                m_head = 0;
            }
        }
        m_container.at(m_tail) = item;
        ++m_tail;
        ++m_csize;
        if(m_csize > m_tsize) {
            m_csize = m_tsize;
        }
    };
    
    /**
     * @brief Removes the element at the head of the buffer.
     * @throws std::runtime_error If the buffer is empty.
     */
    void pop() {
        if(empty()) {
            // Empty buffer exception
            throw std::runtime_error("Buffer is empty.");
        }
        if(1u == m_csize) {
            --m_csize;
            return;
        }
        ++m_head;
        if(m_head >= N) {
            m_head = 0;
        }
        --m_csize;
    };

    /**
     * @brief Returns a constant reference to the head element of the buffer.
     * @return A constant reference to the head element.
     * @throws None.
     */
    T const& head() const noexcept { return m_container[m_head]; };

    /**
     * @brief Returns a constant reference to the tail element of the buffer.
     * @return A constant reference to the tail element.
     * @throws None.
     */
    T const& tail() const noexcept { return m_container[m_tail]; };

    /**
     * @brief Returns the maximum size of the buffer.
     * @return The maximum size of the buffer.
     * @throws None.
     */
    const uint32_t tsize() const noexcept { return m_tsize; };

    /**
     * @brief Returns the current size of the buffer.
     * @return The current size of the buffer.
     * @throws None.
     */
    const uint32_t csize() const noexcept { return m_csize; };

    /**
     * @brief Returns true if the buffer is empty, false otherwise.
     * @return True if the buffer is empty, false otherwise.
     * @throws None.
     */
    bool empty() const noexcept { return m_csize == 0; };

    /**
     * @brief The destructor.
     */
    ~circular_buffer() = default;
};

