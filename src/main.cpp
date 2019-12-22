#include <iostream>
#include <stdexcept>
#include <string>

#include "engine.h"

int main(int, char * []) {
#ifdef NDEBUG
	try {
#endif
		// load level 1 world
		Engine::get_instance().load("lvl1");

		// run engine
		Engine::get_instance().start();
#ifdef NDEBUG
	}
	catch (std::runtime_error & err) {
		std::cerr << err.what() << std::endl;

		return 1;
	}
#endif

	return 0;
}
