package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.PhieuGiamGia;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class PhieuGiamGiaRepository {
    public List<PhieuGiamGia> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from PhieuGiamGia ", PhieuGiamGia.class).list();
        }
    }

    public PhieuGiamGia getOne(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            return session.find(PhieuGiamGia.class,id);
        }
    }

    public void add(PhieuGiamGia phieuGiamGia){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.persist(phieuGiamGia);
            transaction.commit();
        }
    }

    public void update(PhieuGiamGia phieuGiamGia){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.merge(phieuGiamGia);
            transaction.commit();
        }
    }

    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            PhieuGiamGia phieuGiamGia = session.find(PhieuGiamGia.class,id);
            if(id!=null){
                session.delete(phieuGiamGia);
            }
            transaction.commit();
        }
    }
}