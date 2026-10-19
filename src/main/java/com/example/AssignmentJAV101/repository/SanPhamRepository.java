package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.SanPham;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class SanPhamRepository {
    public List<SanPham> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from SanPham ", SanPham.class).list();
        }
    }

    public SanPham getOne(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            return session.find(SanPham.class,id);
        }
    }

    public void add(SanPham sanPham){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.persist(sanPham);
            transaction.commit();
        }
    }

    public void update(SanPham sanPham){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.merge(sanPham);
            transaction.commit();
        }
    }

    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            SanPham sanPham = session.find(SanPham.class,id);
            if(id!=null){
                session.delete(sanPham);
            }
            transaction.commit();
        }
    }
}