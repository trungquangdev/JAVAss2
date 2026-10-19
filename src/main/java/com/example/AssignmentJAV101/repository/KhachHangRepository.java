package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.KhachHang;

import com.example.AssignmentJAV101.util.Hibernate;
import lombok.var;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class KhachHangRepository {
    public List<KhachHang> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from KhachHang ", KhachHang.class).list();
        }
    }

//    public static void main(String[] args) {
//        KhachHangRepository rp = new KhachHangRepository();
//        List<KhachHang> list=rp.getAll();
//        for(KhachHang kh: list){
//            System.out.println(kh.getTen() + "/" + kh.getDiaChi());
//        }
//    }

    public KhachHang getOne(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            return session.find(KhachHang.class,id);
        }
    }
    public void add(KhachHang khachHang){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.persist(khachHang);
            transaction.commit();
        }
    }
    public void update(KhachHang khachHang){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.merge(khachHang);
            transaction.commit();
        }
    }
    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            KhachHang khachHang = session.find(KhachHang.class,id);
            if(id!=null){
                session.delete(khachHang);
            }
            transaction.commit();
        }
    }

    public List<KhachHang> search(String keyword, Integer trangThai) {
        try (Session session = Hibernate.getFactory().openSession()) {
            StringBuilder hql = new StringBuilder("from KhachHang where 1=1");
            if (keyword != null && !keyword.trim().isEmpty()) {
                hql.append(" and (ma like :kw or ten like :kw or sdt like :kw or email like :kw or diaChi like :kw)");
            }
            if (trangThai != null) {
                hql.append(" and trangThai = :tt");
            }
            var query = session.createQuery(hql.toString(), KhachHang.class);
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
