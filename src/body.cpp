#include <SDL2/SDL.h>

#include "spec.h"
#include "world.h"

#include "body.h"

Body::Body(const std::string & name, bool f) : Sprite(name), hardness(Spec::get_instance().get_float(name + "/hardness")), elasticity(Spec::get_instance().get_float(name + "/elasticity")), fixed(f) {}

Body::Body(const Body & b) : Sprite(b), hardness(b.hardness), elasticity(b.elasticity), fixed(b.fixed) {}

void Body::update(unsigned int ticks, World & world) {
	// apply basic rigid body mechanics for each sprite
	for (Body * body : world.get_all<Body>()) {
		// ignore self and fixed bodies
		if (body == this || body->is_fixed())
			continue;

		// get collision area
		SDL_Rect area = collision_strategy->intersection(*this, *body);

		// get collision normal
		Vector2f normal = collision_strategy->get(*this, *body);

		// check for collision
		if (normal.get_x() == 0 && normal.get_y() == 0)
			continue;

		// set velocity to normal
		body->set_velocity_x(body->get_velocity_x()/(std::abs(area.w*normal.get_x())*hardness + 1) + elasticity*area.w*normal.get_x());
		body->set_velocity_y(body->get_velocity_y()/(std::abs(area.h*normal.get_y())*hardness + 1) + elasticity*area.h*normal.get_y());
	}

	Sprite::update(ticks, world);
}