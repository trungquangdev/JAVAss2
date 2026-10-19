package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.ChiTietSanPham;
import com.example.AssignmentJAV101.util.Hibernate;
import lombok.var;
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
    }public List<ChiTietSanPham> search(Integer idSanPham, Integer idMauSac, Integer idKichCo, Integer trangThai) {
        try (Session session = Hibernate.getFactory().openSession()) {
            StringBuilder hql = new StringBuilder("from ChiTietSanPham where 1=1");
            if (idSanPham != null) {
                hql.append(" and sanPham.id = :idSP");
            }
            if (idMauSac != null) {
                hql.append(" and mauSac.id = :idMS");
            }
            if (idKichCo != null) {
                hql.append(" and kichCo.id = :idKC");
            }
            if (trangThai != null) {
                hql.append(" and trangThai = :tt");
            }

            var query = session.createQuery(hql.toString(), ChiTietSanPham.class);
            if (idSanPham != null) query.setParameter("idSP", idSanPham);
            if (idMauSac != null) query.setParameter("idMS", idMauSac);
            if (idKichCo != null) query.setParameter("idKC", idKichCo);
            if (trangThai != null) query.setParameter("tt", trangThai);

            return query.list();
        }
    }
}