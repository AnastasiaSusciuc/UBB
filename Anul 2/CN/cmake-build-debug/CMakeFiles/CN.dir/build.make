# CMAKE generated file: DO NOT EDIT!
# Generated by "MinGW Makefiles" Generator, CMake Version 3.17

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

SHELL = cmd.exe

# The CMake executable.
CMAKE_COMMAND = "C:\Program Files\JetBrains\CLion 2020.3.3\bin\cmake\win\bin\cmake.exe"

# The command to remove a file.
RM = "C:\Program Files\JetBrains\CLion 2020.3.3\bin\cmake\win\bin\cmake.exe" -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "C:\Users\susci\Desktop\Facultate\Anul 2\CN"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "C:\Users\susci\Desktop\Facultate\Anul 2\CN\cmake-build-debug"

# Include any dependencies generated for this target.
include CMakeFiles/CN.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/CN.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/CN.dir/flags.make

CMakeFiles/CN.dir/main.cpp.obj: CMakeFiles/CN.dir/flags.make
CMakeFiles/CN.dir/main.cpp.obj: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="C:\Users\susci\Desktop\Facultate\Anul 2\CN\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/CN.dir/main.cpp.obj"
	C:\PROGRA~1\MINGW-~1\X86_64~1.0-P\mingw64\bin\G__~1.EXE  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles\CN.dir\main.cpp.obj -c "C:\Users\susci\Desktop\Facultate\Anul 2\CN\main.cpp"

CMakeFiles/CN.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/CN.dir/main.cpp.i"
	C:\PROGRA~1\MINGW-~1\X86_64~1.0-P\mingw64\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "C:\Users\susci\Desktop\Facultate\Anul 2\CN\main.cpp" > CMakeFiles\CN.dir\main.cpp.i

CMakeFiles/CN.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/CN.dir/main.cpp.s"
	C:\PROGRA~1\MINGW-~1\X86_64~1.0-P\mingw64\bin\G__~1.EXE $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "C:\Users\susci\Desktop\Facultate\Anul 2\CN\main.cpp" -o CMakeFiles\CN.dir\main.cpp.s

# Object files for target CN
CN_OBJECTS = \
"CMakeFiles/CN.dir/main.cpp.obj"

# External object files for target CN
CN_EXTERNAL_OBJECTS =

CN.exe: CMakeFiles/CN.dir/main.cpp.obj
CN.exe: CMakeFiles/CN.dir/build.make
CN.exe: CMakeFiles/CN.dir/linklibs.rsp
CN.exe: CMakeFiles/CN.dir/objects1.rsp
CN.exe: CMakeFiles/CN.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="C:\Users\susci\Desktop\Facultate\Anul 2\CN\cmake-build-debug\CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable CN.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles\CN.dir\link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/CN.dir/build: CN.exe

.PHONY : CMakeFiles/CN.dir/build

CMakeFiles/CN.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles\CN.dir\cmake_clean.cmake
.PHONY : CMakeFiles/CN.dir/clean

CMakeFiles/CN.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MinGW Makefiles" "C:\Users\susci\Desktop\Facultate\Anul 2\CN" "C:\Users\susci\Desktop\Facultate\Anul 2\CN" "C:\Users\susci\Desktop\Facultate\Anul 2\CN\cmake-build-debug" "C:\Users\susci\Desktop\Facultate\Anul 2\CN\cmake-build-debug" "C:\Users\susci\Desktop\Facultate\Anul 2\CN\cmake-build-debug\CMakeFiles\CN.dir\DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/CN.dir/depend

