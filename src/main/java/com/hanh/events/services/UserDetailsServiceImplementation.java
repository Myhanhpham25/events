package com.hanh.events.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hanh.events.models.User;
import com.hanh.events.respositories.UserRepository;



@Service
public class UserDetailsServiceImplementation implements UserDetailsService {
	private UserRepository userRepository;

	public UserDetailsServiceImplementation(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		User user = userRepository.findByEmail(email);

		if (user == null) {
			throw new UsernameNotFoundException("User not found");
		}

		return new org.springframework.security.core.userdetails.User(user.getEmail(), user.getPassword(),
				getAuthorities(user));
	}

	private List<GrantedAuthority> getAuthorities(User user){
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        GrantedAuthority grantedAuthority = new SimpleGrantedAuthority("ROLE_USER");
        authorities.add(grantedAuthority);
        return authorities;
    }
}