//! @author Mohamed Ashraf
//
//! Used to import stadnard (cout, cin)
#include <iostream>

#include "circular_buffer.hpp"

//! Namespace included for the project
namespace buffer {
//! --------------------- Container section
    // Constructor
    template <typename _T, uint32_t _N>
    myContainer<_T, _N>::myContainer() noexcept : m_size(0), m_full(false) {
        //! Allocate & Initializea the buffer
        m_buffer = new _T[_N] {0};
    };
    // Copy constructor
    template <typename _T, uint32_t _N>
    myContainer<_T, _N>::myContainer(const myContainer& other) noexcept : m_size(0), m_full(false) {
        //! Handle self reference
        if(other == this) {
            return;
        }
        //! Delete old buffer
        if(m_buffer) {
            delete[] m_buffer;
        }
        //! Allocate the buffer
        m_buffer = new _T[_N] {0};
        //! Copy the buffer
        for(uint32_t i = 0; i < _N; i++) {
            m_buffer[i] = other.m_buffer[i];
        }
    };
    // Move constructor
    template <typename _T, uint32_t _N>
    myContainer<_T, _N>::myContainer(myContainer&& other) noexcept : m_buffer(other.buffer), m_size(0), m_full(false) {
        other.m_buffer = nullptr;
        other.m_size = 0;
        other.m_full = false;
    }
    // Copy assignment
    template <typename _T, uint32_t _N>
    myContainer<_T, _N>& myContainer<_T, _N>::operator=(const myContainer& other) noexcept {
        //! Handle self reference
        if(other == this) {
            std::cout << "Self reference copy assignment. \n";
            return *this;
        }
        //! Delete old buffer
        if(m_buffer) {
            delete[] m_buffer;
        }
        //! Allocate the buffer
        m_buffer = new _T[_N] {0};
        //! Copy the buffer
        for(uint32_t i = 0; i < _N; i++) {
            m_buffer[i] = other.m_buffer[i];
        }
    }
    // Move assignment
    template <typename _T, uint32_t _N>
    myContainer<_T, _N>& myContainer<_T, _N>::operator=(myContainer&& other) noexcept {
        //! Handle self reference
        if(other == this) {
            std::cout << "Self reference move assignment. \n";
            return *this;
        }
        //! Delete old buffer
        if(m_buffer) {
            delete[] m_buffer;
        }
        //! Move the buffer
        m_buffer = other.m_buffer;
        //! Reset the other buffer
        other.m_buffer = nullptr;
    }

    template <typename _T, uint32_t _N>
    void myContainer<_T, _N>::push(const _T& value) noexcept {
        //! Check if the buffer is full
        if(m_full) {
            std::cout << "Buffer is full. \n";
            return;
        }
        //! Push the value
        m_buffer[m_size] = value;
        //! Increment the size
        m_size++;
        //! Check if the buffer is full
        if(m_size == _N) {
            m_full = true;
        }
    }
    
    template <typename _T, uint32_t _N>
    _T myContainer<_T, _N>::pop() noexcept {
        //! Check if the buffer is empty
        if(m_size == 0) {
            std::cout << "Buffer is empty. \n";
            return m_buffer[0];
        }
        //! Decrement the size
        m_size--;
        //! Check if the buffer is empty
        if(m_size == 0) {
            m_full = false;
        }
        //! Return the value
        return m_buffer[m_size];
    }

    template <typename _T, uint32_t _N>
    _T& myContainer<_T, _N>::front() noexcept {
        return m_buffer[m_size];
    }

    template <typename _T, uint32_t _N>
    _T& myContainer<_T, _N>::back() noexcept {
        return m_buffer[0];
    }

    template <typename _T, uint32_t _N>
    uint32_t myContainer<_T, _N>::size() noexcept {
        return m_size;
    }

    template <typename _T, uint32_t _N>
    bool myContainer<_T, _N>::empty() noexcept {
        return (m_size == 0);
    }
    
    template <typename _T, uint32_t _N>
    myContainer<_T, _N>::~myContainer() {
        //! Free the buffer
        delete[] m_buffer;
    };

//! --------------------- Buffer section
    template <typename _T, uint32_t _N>
    CircularBuffer<_T, _N>::CircularBuffer() noexcept : m_container(0), m_head(0), m_tail(0), m_size(0) {};
    
    template <typename _T, uint32_t _N>
    void CircularBuffer<_T, _N>::push(const _T& value) noexcept {
        m_container.push(value);
    };

    template <typename _T, uint32_t _N>
    _T CircularBuffer<_T, _N>::pop() noexcept {
        return m_container.pop();
    };

    template <typename _T, uint32_t _N>
    _T& CircularBuffer<_T, _N>::front() noexcept {
        return m_container.front();
    };

    template <typename _T, uint32_t _N>
    _T& CircularBuffer<_T, _N>::back() noexcept {
        return m_container.back();
    };

    template <typename _T, uint32_t _N>
    uint32_t CircularBuffer<_T, _N>::size() noexcept {
        return m_size;
    };

    template <typename _T, uint32_t _N>
    bool CircularBuffer<_T, _N>::empty() noexcept {
        return (m_size == 0);
    };

    template <typename _T, uint32_t _N>
    CircularBuffer<_T, _N>::~CircularBuffer() {};
}