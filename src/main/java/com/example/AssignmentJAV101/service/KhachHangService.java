package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.KhachHang;
import com.example.AssignmentJAV101.repository.KhachHangRepository;

import java.util.List;

public class KhachHangService {
    private final KhachHangRepository khachHangRepository = new KhachHangRepository();

    public List<KhachHang> getAll() {
        return khachHangRepository.getAll();
    }

    public KhachHang getOne(Integer id) {
        return khachHangRepository.getOne(id);
    }

    public void add(KhachHang khachHang) {
        khachHangRepository.add(khachHang);
    }

    public void update(KhachHang khachHang) {
        khachHangRepository.update(khachHang);
    }

    public void delete(Integer id) {
        khachHangRepository.delete(id);
    }

    public List<KhachHang> search(String keyword, Integer trangThai) {
        return khachHangRepository.search(keyword, trangThai);
    }
    public List<KhachHang> getPage(int page, int pageSize, String keyword, Integer trangThai) {
        return khachHangRepository.getPage(page, pageSize, keyword, trangThai);
    }

    public long count(String keyword, Integer trangThai) {
        return khachHangRepository.count(keyword, trangThai);
    }
}
