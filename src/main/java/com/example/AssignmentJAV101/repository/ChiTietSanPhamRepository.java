package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.ChiTietSanPham;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class ChiTietSanPhamRepository {
    public List<ChiTietSanPham> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from ChiTietSanPham ", ChiTietSanPham.class).list();
        }
    }

    public ChiTietSanPham getOne(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            return session.find(ChiTietSanPham.class,id);
        }
    }

    public void add(ChiTietSanPham chiTietSanPham){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.persist(chiTietSanPham);
            transaction.commit();
        }
    }

    public void update(ChiTietSanPham chiTietSanPham){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.merge(chiTietSanPham);
            transaction.commit();
        }
    }

    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            ChiTietSanPham chiTietSanPham = session.find(ChiTietSanPham.class,id);
            if(id!=null){
                session.delete(chiTietSanPham);
            }
            transaction.commit();
        }
    }
}