//! Learning Design Patterns 
//! @author Mohamed Ashraf
//
#include <string>
#include <iostream>

template<typename T, std::size_t size>
class WXContainer {
private:
    T* m_container;
    std::size_t m_size;
public:
    WXContainer(std::size_t sz = size) : m_size(sz) {
        m_container = new T[sz];
    }

    // Iterator subclass
    struct Iterator {
    public:
        using category = std::forward_iterator_tag;
        using distance = std::ptrdiff_t;
        using value_type = T;
        using pointer = T*;
        using refrence = T&;

        // Iterator constructor
        Iterator(pointer ptr) : m_ptr(ptr) {}

        refrence operator*() const { return *m_ptr; }

        pointer operator->() const { return m_ptr; }

        Iterator& operator++() { 
            ++m_ptr; 
            return *this;
        }
        
        Iterator operator++(T) { 
            Iterator tmp = *this;
            ++(*this);
            return tmp;
        } 

        friend bool operator==(const Iterator& me, const Iterator& other) {
            return (me.m_ptr == other.m_ptr);
        }

        friend bool operator!=(const Iterator& me, const Iterator& other) {
            return (me.m_ptr != other.m_ptr);
        }
    private:
        pointer m_ptr;
    };

    Iterator begin() { return Iterator(&m_container[0]); }
    Iterator end() { return Iterator(&m_container[size]); }
    
    T& operator[](std::size_t idx) { return m_container[idx]; }
    std::size_t capacity() { return m_size; } 

    ~WXContainer() {
        if(nullptr != m_container) {
            delete[] m_container;
            m_container = nullptr;
        }
    }
};

int main() {
    WXContainer<int, 10> wxcontainer;

    for (std::size_t i = 0; i < wxcontainer.capacity(); ++i) {
        wxcontainer[i] = i;
    }

    std::for_each(wxcontainer.begin(), wxcontainer.end(), [](auto& e) -> void {
        std::cout << e << "\n";
    });

    return 0;
}


