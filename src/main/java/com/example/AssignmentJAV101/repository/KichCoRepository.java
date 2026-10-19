package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.KichCo;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class KichCoRepository {
    public List<KichCo> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from KichCo ", KichCo.class).list();
        }
    }

    public KichCo getOne(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            return session.find(KichCo.class,id);
        }
    }

    public void add(KichCo kichCo){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.persist(kichCo);
            transaction.commit();
        }
    }

    public void update(KichCo kichCo){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.merge(kichCo);
            transaction.commit();
        }
    }

    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            KichCo kichCo = session.find(KichCo.class,id);
            if(id!=null){
                session.delete(kichCo);
            }
            transaction.commit();
        }
    }
}