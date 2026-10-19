package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.HoaDon;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class HoaDonRepository {
    public List<HoaDon> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from HoaDon", HoaDon.class).list();
        }
    }

    public HoaDon getOne(Integer id) {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.find(HoaDon.class, id);
        }
    }

    public void add(HoaDon hoaDon) {
        try (Session session = Hibernate.getFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            session.persist(hoaDon);
            transaction.commit();
        }
    }

    public void update(HoaDon hoaDon) {
        try (Session session = Hibernate.getFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            session.merge(hoaDon);
            transaction.commit();
        }
    }

    public void delete(Integer id) {
        try (Session session = Hibernate.getFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            HoaDon hoaDon = session.find(HoaDon.class, id);
            if (hoaDon != null) {
                session.delete(hoaDon);
            }
            transaction.commit();
        }
    }
}