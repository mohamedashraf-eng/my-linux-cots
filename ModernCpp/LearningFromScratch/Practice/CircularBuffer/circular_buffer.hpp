#ifndef CIRCULAR_BUFFER_H
#define CIRCULAR_BUFFER_H

#pragma once

namespace buffer {
//! Define the prototype for the class.
//! Using Rule of Five.
//! RAII.
//! Smart Pointers.
//! Template for datatype, size

    //! Class container to handle dynamic buffers
    template <typename _T, uint32_t _N>
    class myContainer {
    private:
        // Pointer to store a dynamic buffer.
        _T& m_buffer;
        uint32_t m_size;
        bool m_full;
    public:
        // Constructor
        myContainer() noexcept;
        // Copy constructor
        myContainer(const myContainer& other) noexcept;
        // Move constructor
        myContainer(myContainer&& other) noexcept;
        // Copy assignment
        myContainer& operator=(const myContainer& other) noexcept;
        // Move assignment
        myContainer& operator=(myContainer&& other) noexcept;

        void push(const _T& value) noexcept;
        _T pop() noexcept;
        _T& front() noexcept;
        _T& back() noexcept;
        uint32_t size() noexcept;
        bool empty() noexcept;

        // Destructor
        ~myContainer();
    };

    template <typename _T, uint32_t _N> 
    class CircularBuffer {
    private:
        myContainer<_T, _N> m_container;
        // 
        uint32_t m_head;
        uint32_t m_tail;
        uint32_t m_size;
    public:
        CircularBuffer() noexcept;
        
        void push(const _T& value) noexcept;
        _T pop() noexcept;
        _T& front() noexcept;
        _T& back() noexcept;
        uint32_t size() noexcept;
        bool empty() noexcept;

        ~CircularBuffer();
    };
}

#endif /* CIRCULAR_BUFFER_H */



