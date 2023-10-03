ifdef VERBOSE
  NINJA_FLAGS := -v
endif

ifdef WORKAROUND
CMAKE_FLAGS := -DWORKAROUND=TRUE
endif

all:
	mkdir -p .build
	cmake -B .build -G Ninja -DCMAKE_BUILD_TYPE=Debug . $(CMAKE_FLAGS)
	ninja -C .build $(NINJA_FLAGS)

clean:
	rm -rf .build
