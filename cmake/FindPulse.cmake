
include(FindPkgConfig)

if(PKG_CONFIG_FOUND)
	pkg_check_modules(PULSE libpulse)
endif()

find_path(PULSE_INCLUDE_DIR pulse/pulseaudio.h PATHS ${PULSE_INCLUDE_DIRS} PATH_SUFFIXES pulse )
find_library(PULSE_LIBRARY pulse PATHS ${PULSE_LIBRARY_DIRS})

FIND_PACKAGE_HANDLE_STANDARD_ARGS(Pulse DEFAULT_MSG PULSE_INCLUDE_DIR PULSE_LIBRARY)

if(PULSE_LIBRARY)
	execute_process(COMMAND "pactl" "--version" OUTPUT_VARIABLE PULSE_VERSION_OUTPUT)

	STRING(REGEX MATCH "[0-9]+.[0-9]+.[0-9]+" PULSE_VERSION "${PULSE_VERSION_OUTPUT}")
	if(NOT PULSE_VERSION)
		message(FATAL_ERROR "PulseAudio is not installed")
	endif()
endif()

mark_as_advanced(PULSE_INCLUDE_DIR PULSE_LIBRARY PULSE_VERSION)

