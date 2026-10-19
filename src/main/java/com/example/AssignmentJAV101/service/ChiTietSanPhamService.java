package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.ChiTietSanPham;
import com.example.AssignmentJAV101.repository.ChiTietSanPhamRepository;

import java.util.List;

public class ChiTietSanPhamService {
    private final ChiTietSanPhamRepository chiTietSanPhamRepository = new ChiTietSanPhamRepository();

    public List<ChiTietSanPham> getAll() {
        return chiTietSanPhamRepository.getAll();
    }

    public ChiTietSanPham getOne(Integer id) {
        return chiTietSanPhamRepository.getOne(id);
    }

    public void add(ChiTietSanPham chiTietSanPham) {
        chiTietSanPhamRepository.add(chiTietSanPham);
    }

    public void update(ChiTietSanPham chiTietSanPham) {
        chiTietSanPhamRepository.update(chiTietSanPham);
    }

    public void delete(Integer id) {
        chiTietSanPhamRepository.delete(id);
    }
    public List<ChiTietSanPham> search(Integer idSanPham, Integer idMauSac, Integer idKichCo, Integer trangThai) {
        return chiTietSanPhamRepository.search(idSanPham, idMauSac, idKichCo, trangThai);
    }public List<ChiTietSanPham> getPage(int page, int pageSize, Integer idSP, Integer idMS, Integer idKC, Integer tt) {
        return chiTietSanPhamRepository.getPage(page, pageSize, idSP, idMS, idKC, tt);
    }
    public long count(Integer idSP, Integer idMS, Integer idKC, Integer tt) {
        return chiTietSanPhamRepository.count(idSP, idMS, idKC, tt);
    }
}