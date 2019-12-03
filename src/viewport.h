#ifndef VIEWPORT_H
#define VIEWPORT_H
#include "drawable.h"
#include "vector2f.h"
#include "world.h"

class Viewport {
	public:
		Viewport();
		~Viewport() {}

		Viewport(const Viewport &) = delete;
		const Viewport & operator=(const Viewport &) = delete;

		void dispatch(const SDL_Event &) {}
		void draw() const {}
		void update(unsigned int ticks, World & world);

		int get_height() const { return height; }
		int get_width() const  { return width; }

		Vector2f get_position() const { return position; }

		float get_x() const  { return position[0]; }
		void  set_x(float x) { position[0] = x; }
		float get_y() const  { return position[1]; }
		void  set_y(float y) { position[1] = y; }

		void track(const Drawable * obj)      { tracking = obj;  };
		const Drawable * get_tracking() const { return tracking; }

	private:
		Vector2f position;
		int width, height;

		const Drawable * tracking;
};
#endif
