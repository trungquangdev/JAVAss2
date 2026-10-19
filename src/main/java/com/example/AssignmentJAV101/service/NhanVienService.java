package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.NhanVien;
import com.example.AssignmentJAV101.repository.NhanVienRepository;
import com.example.AssignmentJAV101.util.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;


import java.util.List;

public class NhanVienService {
    private final NhanVienRepository nhanVienRepository = new NhanVienRepository();

    public List<NhanVien>getAll(){
        return nhanVienRepository.getAll();
    }
    public NhanVien getOne(Integer id){
        return nhanVienRepository.getOne(id);
    }
    public void add(NhanVien nhanVien){
        nhanVienRepository.add(nhanVien);
    }
    public void update(NhanVien nhanVien){
        nhanVienRepository.update(nhanVien);
    }
    public void delete(Integer id){
        nhanVienRepository.delete(id);
    }
    public List<NhanVien> search(String keyword, Integer trangThai) {
        return nhanVienRepository.search(keyword, trangThai);
    }
}
