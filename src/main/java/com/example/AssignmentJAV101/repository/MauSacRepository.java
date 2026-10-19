package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.MauSac;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class MauSacRepository {

    public List<MauSac> getAll() {

        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from MauSac", MauSac.class).list();
        }
    }

    public MauSac getOne(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            return session.find(MauSac.class,id);
        }
    }

    public void add(MauSac mauSac){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.persist(mauSac);
            transaction.commit();
        }
    }

    public void update(MauSac mauSac){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.merge(mauSac);
            transaction.commit();
        }
    }

    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            MauSac mauSac = session.find(MauSac.class,id);
            if(id!=null){
                session.delete(mauSac);
            }
            transaction.commit();
        }
    }
}
