package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.HoaDon;
import com.example.AssignmentJAV101.util.Hibernate;
import lombok.var;
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
    }public List<HoaDon> getPage(int page, int pageSize, String keyword, Integer trangThai) {
        try (Session session = Hibernate.getFactory().openSession()) {
            StringBuilder hql = new StringBuilder("from HoaDon where 1=1");
            if (keyword != null && !keyword.trim().isEmpty()) {
                hql.append(" and (maHoaDon like :kw or khachHang.ten like :kw or nhanVien.ten like :kw)");
            }
            if (trangThai != null) {
                hql.append(" and trangThai = :tt");
            }
            var query = session.createQuery(hql.toString(), HoaDon.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + keyword.trim() + "%");
            }
            if (trangThai != null) {
                query.setParameter("tt", trangThai);
            }
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.list();
        }
    }

    public long count(String keyword, Integer trangThai) {
        try (Session session = Hibernate.getFactory().openSession()) {
            StringBuilder hql = new StringBuilder("select count(id) from HoaDon where 1=1");
            if (keyword != null && !keyword.trim().isEmpty()) {
                hql.append(" and (maHoaDon like :kw or khachHang.ten like :kw or nhanVien.ten like :kw)");
            }
            if (trangThai != null) {
                hql.append(" and trangThai = :tt");
            }
            var query = session.createQuery(hql.toString(), Long.class);
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + keyword.trim() + "%");
            }
            if (trangThai != null) {
                query.setParameter("tt", trangThai);
            }
            return query.uniqueResult();
        }
    }
}