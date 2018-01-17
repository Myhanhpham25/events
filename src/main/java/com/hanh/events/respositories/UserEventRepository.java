package com.hanh.events.respositories;

import org.springframework.data.repository.CrudRepository;

import com.hanh.events.models.UserEvent;


public interface UserEventRepository extends CrudRepository<UserEvent, Long> {

}
