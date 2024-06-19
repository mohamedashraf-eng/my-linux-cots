#pragma once

// Observer class
class Observer {
public:
    virtual void update() = 0;
    virtual ~Observer() = default;
};
