package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.HoaDonChiTiet;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class HoaDonChiTietRepository {
    public List<HoaDonChiTiet> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from HoaDonChiTiet", HoaDonChiTiet.class).list();
        }
    }

    public HoaDonChiTiet getOne(Integer id) {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.find(HoaDonChiTiet.class, id);
        }
    }

    public void add(HoaDonChiTiet hoaDonChiTiet) {
        try (Session session = Hibernate.getFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            session.persist(hoaDonChiTiet);
            transaction.commit();
        }
    }

    public void update(HoaDonChiTiet hoaDonChiTiet) {
        try (Session session = Hibernate.getFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            session.merge(hoaDonChiTiet);
            transaction.commit();
        }
    }

    public void delete(Integer id) {
        try (Session session = Hibernate.getFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            HoaDonChiTiet hoaDonChiTiet = session.find(HoaDonChiTiet.class, id);
            if (hoaDonChiTiet != null) {
                session.delete(hoaDonChiTiet);
            }
            transaction.commit();
        }
    }
}