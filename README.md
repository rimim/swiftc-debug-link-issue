The issues is reproducible with Xcode14 but is an error in Xcode15. The issue is that when you specify -DCMAKE_BUILD_TYPE=Debug cmake will add "-g" the options passed to swiftc and when you have more than 128 swift source files in your library the .swiftmodule file is added to the linker input files. Xcode14 and possibly earlier only considered this a warning but Xcode15 reports it as an error. Removing "-g" from the CMAKE_Swift_FLAGS_DEBUG will allow the library to compile but without debug info.

## Build using Xcode14:

    make clean && make
    ...
    ninja: Entering directory `.build'
    [1/1] Linking Swift shared library lib/libDummyLibrary.dylib
    ld: warning: ignoring file swift/DummyLibrary.swiftmodule, building for macOS-arm64 but attempting to link with file built for unknown-unsupported file format ( 0xE2 0x9C 0xA8 0x0E 0x01 0x08 0x00 0x00 0x7D 0x0B 0x00 0x00 0x07 0x01 0xB2 0xC0 )

## Build using Xcode15:

    make clean && make
    ...
    error: link command failed with exit code 1 (use -v to see invocation)
    ld: unknown file type in '/Users/mimir/Research/swiftc-debug-link-bug/.build/swift/DummyLibrary.swiftmodule'
    clang: error: linker command failed with exit code 1 (use -v to see invocation)
    error: fatalError
    ninja: build stopped: subcommand failed.
