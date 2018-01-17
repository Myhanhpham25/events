package com.hanh.events.respositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.hanh.events.models.Comment;

@Repository
public interface CommentRepository extends CrudRepository<Comment, Long>{

}
