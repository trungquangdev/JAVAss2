package com.example.AssignmentJAV101.repository;

import com.example.AssignmentJAV101.model.NhanVien;
import com.example.AssignmentJAV101.util.Hibernate;
import lombok.var;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class NhanVienRepository {
    public List<NhanVien> getAll(){
        try(Session session = Hibernate.getFactory().openSession()){
            return session.createQuery("from NhanVien ", NhanVien.class).list();
        }
    }

//    public static void main(String[] args) {
//        NhanVienRepository rp=new NhanVienRepository();
//        List<NhanVien>list=rp.getAll();
//        for(NhanVien nv: list){
//            System.out.println(nv.getMa()+" "+nv.getTen());
//        }
//    }

    public NhanVien getOne(Integer id){
        try(Session session = Hibernate.getFactory().openSession()){
           return session.find(NhanVien.class,id);
        }
    }

    public void add(NhanVien nhanVien){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction tran = session.beginTransaction();
            session.persist(nhanVien);
            tran.commit();
        }
    }

    public void update(NhanVien nhanVien){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction tran = session.beginTransaction();
            session.merge(nhanVien);
            tran.commit();
        }
    }

    public void delete(Integer id){
        try(Session session=Hibernate.getFactory().openSession()){
            Transaction tran = session.beginTransaction();
            NhanVien nhanVien=session.find(NhanVien.class,id);
            if(nhanVien !=null){
                session.delete(nhanVien);
            }
            tran.commit();
        }
    }

    public List<NhanVien> search(String keyword, Integer trangThai) {
        try (Session session = Hibernate.getFactory().openSession()) {
            StringBuilder hql = new StringBuilder("from NhanVien where 1=1");
            if (keyword != null && !keyword.trim().isEmpty()) {
                hql.append(" and (ma like :kw or ten like :kw or email like :kw or sdt like :kw or chucVu like :kw)");
            }
            if (trangThai != null) {
                hql.append(" and trangThai = :tt");
            }
            var query = session.createQuery(hql.toString(), NhanVien.class);
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
