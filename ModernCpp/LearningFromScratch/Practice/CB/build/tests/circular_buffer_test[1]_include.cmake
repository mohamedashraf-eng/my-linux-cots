if(EXISTS "/workspace/ModernCpp/LearningFromScratch/Practice/CB/build/tests/circular_buffer_test[1]_tests.cmake")
  include("/workspace/ModernCpp/LearningFromScratch/Practice/CB/build/tests/circular_buffer_test[1]_tests.cmake")
else()
  add_test(circular_buffer_test_NOT_BUILT circular_buffer_test_NOT_BUILT)
endif()
