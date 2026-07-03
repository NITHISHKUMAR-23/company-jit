stages:
  - build
  - test

# Build Job
build_job:
  stage: build
  script:
    - cd Buffer_copy_Core1
    - cd src
    - echo "Building the project..."
    - apt-get update
    - apt-get install -y build-essential gcc
    - apt-get install -y Buffer_copy_Core1.h
    - gcc -o buffer_copy_Core1 Buffer_copy_Core1.c

# Test Job
test_job:
  stage: test
  script:
    - echo "Running the project..."
    - ./buffer_copy_Core1
  only:
    - main
