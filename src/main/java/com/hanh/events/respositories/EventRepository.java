package com.hanh.events.respositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.hanh.events.models.Event;

@Repository
public interface EventRepository extends CrudRepository<Event, Long> {
	List<Event> findAll();

	List<Event> findEventByStateOrderByEventdateDesc(String state);

	List<Event> findEventByStateNotLike(String state);
}
