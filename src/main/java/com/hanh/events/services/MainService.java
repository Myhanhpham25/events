package com.hanh.events.services;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hanh.events.models.Comment;
import com.hanh.events.models.Event;
import com.hanh.events.models.User;
import com.hanh.events.models.UserEvent;
import com.hanh.events.respositories.CommentRepository;
import com.hanh.events.respositories.EventRepository;
import com.hanh.events.respositories.UserEventRepository;
import com.hanh.events.respositories.UserRepository;

@Service
public class MainService {
	private UserRepository userRepository;

	private UserEventRepository userEventRepository;
	private EventRepository eventRepository;
	private CommentRepository commentRepository;
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	public MainService(UserRepository userRepository, BCryptPasswordEncoder bCryptPasswordEncoder,
			UserEventRepository userEventRepository, EventRepository eventRepository,
			CommentRepository commentRepository) {
		this.userRepository = userRepository;
		this.userEventRepository = userEventRepository;
		this.eventRepository = eventRepository;
		this.commentRepository = commentRepository;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}

	public void saveWithUserRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		userRepository.save(user);
	}

	public User findByEmail(String email) {	
		return userRepository.findByEmail(email);
	}

	public List<User> findAllUsers() {
		return userRepository.findAll();
	}

	// Adding an Event
	public void createEvent(Event event) {
		Event newEvent = eventRepository.save(event);
	}

	// find all events
	public List<Event> findAllEvents() {
		return eventRepository.findAll();
	}

	// Find one Event by ID
	public Event findOneEvent(Long id) {
		return eventRepository.findOne(id);
	}

	// joining user to event, find set save add, sending in event id and user object. 
	//find event object by id and pull up the event users array. add the user object to the users array
	//take the event object and set the updated users array. then grab the event repository and save the updated event object
	public void joinUser(Long id, User user) {
		List<User> users = new ArrayList<User>();
		Event currentEvent = eventRepository.findOne(id);
		List<User> attendees = currentEvent.getUsers();
		attendees.add(user);
		currentEvent.setUsers(attendees);
		eventRepository.save(currentEvent);

	}

	// creating a comment and tying it to event.
	public void createComment(Comment comment) {
		commentRepository.save(comment);
	}

		//deleting event 
	public void deleteEvent(Long id) {
		Event deleteEvent = eventRepository.findOne(id);
		eventRepository.delete(deleteEvent);
		
	}

	//find states by date order
	public List<Event> findEventByStateOrderByEventdateDesc(String state) {	
		return eventRepository.findEventByStateOrderByEventdateDesc(state);
	}

	//find state that's not like user
	public List<Event> findEventByStateNotLike(String state) {	
		return eventRepository.findEventByStateNotLike(state);
	}

		//canceling user from the event, removing them from the event user array list
	public void cancelEvent(Long id, User user) {
		Event event = eventRepository.findOne(id);
		List<User> users = event.getUsers();
		users.remove(user);
		eventRepository.save(event);
	}
}
