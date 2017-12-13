#ifndef INPUT_H
#define INPUT_H
#include <list>
#include <string>

#include <SDL2/SDL.h>

class Input {
	public:
		static Input & get_instance() {
			static Input input;
			return input;
		}

		~Input() {}

		Input(const Input & input) = delete;
		const Input & operator=(const Input & input) = delete;

		void grab(const std::string & name) {
			// add to front of list
			list.push_front(name);
		}

		void release(const std::string & name) {
			// remove all entries from list
			list.remove(name);
		}

		bool check(const std::string & name) const {
			// check if at front of list
			return list.front() == name;
		}

		bool get_key(const SDL_Scancode & key) const {
			return static_cast<bool>(SDL_GetKeyboardState(nullptr)[key]);
		}

	private:
		Input() : list{} {}

		std::list<std::string> list;
};
#endif
