package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.SanPham;
import com.example.AssignmentJAV101.repository.SanPhamRepository;

import java.util.List;

public class SanPhamService {
    private final SanPhamRepository sanPhamRepository = new SanPhamRepository();

    public List<SanPham> getAll() {
        return sanPhamRepository.getAll();
    }

    public SanPham getOne(Integer id) {
        return sanPhamRepository.getOne(id);
    }

    public void add(SanPham sanPham) {
        sanPhamRepository.add(sanPham);
    }

    public void update(SanPham sanPham) {
        sanPhamRepository.update(sanPham);
    }

    public void delete(Integer id) {
        sanPhamRepository.delete(id);
    }

}