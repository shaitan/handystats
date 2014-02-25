#include <memory>

#include <handystats/message_queue_impl.hpp>
#include <handystats/measuring_points/counter_measuring_points.hpp>

namespace handystats { namespace events {

std::shared_ptr<event_message> counter_init_event(const std::string, metrics::counter::value_type, metrics::counter::time_point);
std::shared_ptr<event_message> counter_increment_event(const std::string, metrics::counter::value_type, metrics::counter::time_point);
std::shared_ptr<event_message> counter_decrement_event(const std::string, metrics::counter::value_type, metrics::counter::time_point);

}} // namespace handystats::events


void HANDY_COUNTER_INIT(
		const std::string counter_name,
		handystats::metrics::counter::value_type init_value,
		handystats::metrics::counter::time_point timestamp
		)
{
	auto message = handystats::events::counter_init_event(counter_name, init_value, timestamp);
	handystats::message_queue::push_event_message(message);
}

void HANDY_COUNTER_INCREMENT(
		const std::string counter_name,
		handystats::metrics::counter::value_type value,
		handystats::metrics::counter::time_point timestamp
		)
{
	auto message = handystats::events::counter_increment_event(counter_name, value, timestamp);
	handystats::message_queue::push_event_message(message);
}

void HANDY_COUNTER_DECREMENT(
		const std::string counter_name,
		handystats::metrics::counter::value_type value,
		handystats::metrics::counter::time_point timestamp
		)
{
	auto message = handystats::events::counter_decrement_event(counter_name, value, timestamp);
	handystats::message_queue::push_event_message(message);
}
