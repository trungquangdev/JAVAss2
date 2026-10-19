package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.DotGiamGia;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class DotGiamGiaRepository {
    public List<DotGiamGia> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from DotGiamGia ", DotGiamGia.class).list();
        }
    }

    public DotGiamGia getOne(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            return session.find(DotGiamGia.class,id);
        }
    }

    public void add(DotGiamGia dotGiamGia){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.persist(dotGiamGia);
            transaction.commit();
        }
    }

    public void update(DotGiamGia dotGiamGia){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.merge(dotGiamGia);
            transaction.commit();
        }
    }

    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            DotGiamGia dotGiamGia = session.find(DotGiamGia.class,id);
            if(id!=null){
                session.delete(dotGiamGia);
            }
            transaction.commit();
        }
    }
}