#include <SDL.h>

#include "context.h"
#include "script.h"
#include "spec.h"
#include "text.h"
#include "viewport.h"

#include "console.h"

Console & Console::get_instance() {
	static Console console;
	return console;
}

Console::Console() : Drawable("name", Vector2f{0, 0}, 0, Vector2f{0, 0}, 1, 9002), open(false), command(""), surface(nullptr), padding_bottom(4), padding_left(5), padding_font(2) {
}

void Console::draw(const Viewport & viewport) const {
	if (open) {
		// drawing rectable
		SDL_Rect rect = {padding_left, viewport.get_height() - Text::get_instance().get_size() - padding_bottom - padding_font, viewport.get_width() - padding_left*2, Text::get_instance().get_size() + padding_font*2};

		// draw box
		SDL_SetRenderDrawColor(Context::get_instance().get_renderer(), Spec::get_instance().get_int("console/box/r"), Spec::get_instance().get_int("console/box/g"), Spec::get_instance().get_int("console/box/b"), Spec::get_instance().get_int("console/box/a"));
		SDL_RenderFillRect(Context::get_instance().get_renderer(), &rect);

		// draw text
		SDL_Color color = {static_cast<Uint8>(Spec::get_instance().get_int("console/text/r")), static_cast<Uint8>(Spec::get_instance().get_int("console/text/g")), static_cast<Uint8>(Spec::get_instance().get_int("console/text/b")), 255};
		Text::get_instance().write(Context::get_instance().get_renderer(), command + "█", rect.x + padding_font, rect.y + padding_font, color);
	}
}

void Console::update(unsigned int) {
	const SDL_Event * event = Input::get_instance().get_event();

	if (open) {
		// grab keyboard focus
		if (!Input::get_instance().check("console"))
			Input::get_instance().grab("console");

		if (event->type == SDL_KEYDOWN) {
			if (event->key.keysym.sym == SDLK_BACKQUOTE) {
				// stop text input
				open = false;
				SDL_StopTextInput();
			}
			else if (event->key.keysym.sym == SDLK_BACKSPACE) {
				// backspace
				command.pop_back();
			}
			else if (event->key.keysym.sym == SDLK_RETURN) {
				Script script(command);
				command.clear();
			}
		}
		else if (event->type == SDL_TEXTINPUT) {
			// record text
			command += event->text.text;
		}
	}
	else {
		if (event->type == SDL_KEYDOWN) {
			if (event->key.keysym.sym == SDLK_BACKQUOTE) {
				// open console and start text input so we get TextInput events
				open = true;
				SDL_StartTextInput();

				// grab input
				Input::get_instance().grab("console");
			}
		}
	}
}
