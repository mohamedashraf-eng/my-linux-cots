#pragma once

#include <cstdint>
#include <array>
#include <stdexcept>

template <typename T, uint32_t N>
class circular_buffer {
private:
    uint32_t m_head;
    uint32_t m_tail;
    uint32_t m_tsize;
    uint32_t m_csize;
    std::array<T, N> m_container {0};
public:
    circular_buffer() noexcept : m_head(0), m_tail(0), m_tsize(N), m_csize(0) {};

    circular_buffer(const std::initializer_list<T>& il_values) : m_head(0), m_tail(0), m_tsize(N), m_csize(0) {
        if(il_values.size() > N) {
            throw std::runtime_error("Initializer list is too long.");
        }

        for(auto const& item : il_values) {
            push_back(item);
        }        
    };

    //! Operation methods
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

    //! Getter methods
    T const& head() const noexcept { return m_container[m_head]; };
    T const& tail() const noexcept { return m_container[m_tail]; };
    const uint32_t tsize() const noexcept { return m_tsize; };
    const uint32_t csize() const noexcept { return m_csize; };
    bool empty() const noexcept { return m_csize == 0; };

    //! Iterator methods

    ~circular_buffer() = default;
};