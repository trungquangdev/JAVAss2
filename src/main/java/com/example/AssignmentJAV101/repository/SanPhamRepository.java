package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.SanPham;
import com.example.AssignmentJAV101.util.Hibernate;
import lombok.var;
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

    public List<SanPham> search(String keyword, Integer trangThai) {
        try (Session session = Hibernate.getFactory().openSession()) {
            StringBuilder hql = new StringBuilder("from SanPham where 1=1");

            // Tìm kiếm theo nhiều trường (Mã, Tên, Mô tả)
            if (keyword != null && !keyword.trim().isEmpty()) {
                hql.append(" and (ma like :kw or tenSanPham like :kw or moTa like :kw)");
            }
            // Bộ lọc theo trạng thái
            if (trangThai != null) {
                hql.append(" and trangThai = :tt");
            }

            var query = session.createQuery(hql.toString(), SanPham.class);

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("kw", "%" + keyword.trim() + "%");
            }
            if (trangThai != null) {
                query.setParameter("tt", trangThai);
            }

            return query.list();
        }
    }
}