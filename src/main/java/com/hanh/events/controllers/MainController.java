package com.hanh.events.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hanh.events.models.Comment;
import com.hanh.events.models.Event;
import com.hanh.events.models.User;
import com.hanh.events.services.MainService;
import com.hanh.events.validator.UserValidator;

@Controller
public class MainController {

	private MainService mainService;
	private UserValidator userValidator;

	public MainController(MainService mainService, UserValidator userValidator) {
		this.mainService = mainService;
		this.userValidator = userValidator;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}

	// login and route to dashboard
	@RequestMapping("/login")
	public String login(@ModelAttribute("user") User user,
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, Model model, HttpSession session ) {
		
		String[] states = {"AK","AL","AR", "AS","AZ","CA", "CO","CT", "DC","DE", "FL", "GA",  "GU", "HI", "IA", "ID", "IL", "IN",  "KS", "KY", "LA","MA", "MD","ME","MI","MN", "MO", "MS", "MT","NC", "ND","NE","NH","NJ", "NM","NV","NY", "OH","OK","OR","PA","PR", "RI", "SC","SD",
				"TN", "TX","UT","VA", "VI", "VT","WA","WI","WV", "WY"};
		model.addAttribute("states", states);
		session.setAttribute("states", states);
	
		if (error != null) {
			model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
		}
		if (logout != null) {
			model.addAttribute("logoutMessage", "Logout Successfull!");
		}
		return "index";
	}

	// post - creating registration page
	@PostMapping("/registration")
	public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "index";
		}
		mainService.saveWithUserRole(user);
		return "redirect:/login";
	}

	// principle is equal to session. i also displayed all the users on the same
	// jsut to see what my database have.
	@RequestMapping(value = { "/", "/dashboard" })
	public String home(@ModelAttribute("event") Event event, Principal principal, Model model, HttpSession session) {
		model.addAttribute("users", mainService.findAllUsers());
		String email = principal.getName();
		User cur_user = mainService.findByEmail(email);
		model.addAttribute("cur_user", cur_user);
		model.addAttribute("currentUser", mainService.findByEmail(email).getFirstName());
		model.addAttribute("userId", mainService.findByEmail(email).getId());
		
		model.addAttribute("yourStateEvents", mainService.findEventByStateOrderByEventdateDesc(cur_user.getState()));
        model.addAttribute("nonStateEvents", mainService.findEventByStateNotLike(cur_user.getState()));
		
		session.setAttribute("user_id", mainService.findByEmail(email).getId());		
		model.addAttribute("events", mainService.findAllEvents());
		
		return "dashboard";
	}
	
	//POST adding event to the database 
	@PostMapping("/addEvent")
	public String createEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, Model model) {
		if(result.hasErrors()) {
			System.out.println(result);
			return "dashboard";
		}else {
			mainService.createEvent(event);
			System.out.println("Successfully added Event" + event);
			return "redirect:/dashboard";
		}	
	}
	
	//finding event by id and rendering the event profile
	@RequestMapping(path="/events/{id}")
	public String showOneEvent(@ModelAttribute("comment_") Comment comment_, @PathVariable("id") Long id, Model model, Principal principal) {
		model.addAttribute("event", mainService.findOneEvent(id));
		String email = principal.getName();
		model.addAttribute("username", mainService.findByEmail(email).getFirstName());
		return "showEvent";
	}
	
	//PostMapping addComment to the database
	@PostMapping(path="/addComment")
	public String createComment(@Valid @ModelAttribute("comment_") Comment comment_, BindingResult result, Model model, Principal principal) {
		String email = principal.getName();
		model.addAttribute("userId", mainService.findByEmail(email).getId());
		if(result.hasErrors()) {
			model.addAttribute("comment", comment_.getEvent());
			System.out.println(result);
			return "dashboard";
		}else {
			mainService.createComment(comment_);
			String eventId= String.valueOf(comment_.getEvent().getId());
			System.out.println("eventid" + eventId);
			return "redirect:/events/".concat(eventId);
		}	
	}
	
	//Joining Currentuser to event
	@RequestMapping(path="/join/{id}")
	public String addUserToEvent(@PathVariable("id") Long id, Principal principal){
		String email = principal.getName();
		User user =  mainService.findByEmail(email);
		mainService.joinUser(id, user);
		return "redirect:/";
	}
	
	//RENDER editpage
	@RequestMapping("/events/{id}/edit")
	public String displayEditEvent(@ModelAttribute("event") Event event, @PathVariable("id") Long id,  Model model, HttpSession session){
		model.addAttribute("oldEvent", mainService.findOneEvent(id));
		System.out.println(session.getAttribute("states"));
		return "editEvent";
	}
	
	//POST MAPPING - editing Event and update it
	@PostMapping(path="/events/{id}/edit")
	public String updateEditEvent(@Valid @ModelAttribute("event") Event event, BindingResult result, Model model, @PathVariable("id") Long id) {
		model.addAttribute("oldEvent", mainService.findOneEvent(id));
		if(result.hasErrors()) {
			System.out.println(result);
			return "dashboard";
		}else {
			mainService.createEvent(event);
			return "redirect:/dashboard";
		}	
	}
	
	//Delete Event 
	@RequestMapping("/delete/{id}")
	public String destroy(@PathVariable("id") Long id) {
		mainService.deleteEvent(id);
		return "redirect:/dashboard";
	}
	
	//user cancel attending event. remove user out of the event array list. //need to send event id and user id back to service
	@RequestMapping("/cancel/{id}")
	public String cancelEventMethod(@PathVariable("id") Long id, HttpSession session, Principal principal) {
		session.getAttribute("user_id");
		String email = principal.getName();
		User user =  mainService.findByEmail(email);
		mainService.cancelEvent(id, user);
		return "redirect:/dashboard";
	}
	

}
