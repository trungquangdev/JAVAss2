package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.DotGiamGia;
import com.example.AssignmentJAV101.util.Hibernate;
import lombok.var;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class DotGiamGiaRepository {
    public List<DotGiamGia> getAll() {
        try (Session session = Hibernate.getFactory().openSession()) {
            return session.createQuery("from DotGiamGia ", DotGiamGia.class).list();
        }
    }

    public DotGiamGia getOne(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            return session.find(DotGiamGia.class,id);
        }
    }

    public void add(DotGiamGia dotGiamGia){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.persist(dotGiamGia);
            transaction.commit();
        }
    }

    public void update(DotGiamGia dotGiamGia){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            session.merge(dotGiamGia);
            transaction.commit();
        }
    }

    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction transaction = session.beginTransaction();
            DotGiamGia dotGiamGia = session.find(DotGiamGia.class,id);
            if(id!=null){
                session.delete(dotGiamGia);
            }
            transaction.commit();
        }
    }

    public List<DotGiamGia> search(String keyword, Integer trangThai) {
        try (Session session = Hibernate.getFactory().openSession()) {
            StringBuilder hql = new StringBuilder("from DotGiamGia where 1=1");
            if (keyword != null && !keyword.trim().isEmpty()) {
                hql.append(" and (ma like :kw or tenDot like :kw)");
            }
            if (trangThai != null) {
                hql.append(" and trangThai = :tt");
            }
            var query = session.createQuery(hql.toString(), DotGiamGia.class);
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