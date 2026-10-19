package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.HoaDon;
import com.example.AssignmentJAV101.repository.HoaDonRepository;

import java.util.List;

public class HoaDonService {
    private final HoaDonRepository hoaDonRepository = new HoaDonRepository();

    public List<HoaDon> getAll() {
        return hoaDonRepository.getAll();
    }

    public HoaDon getOne(Integer id) {
        return hoaDonRepository.getOne(id);
    }

    public void add(HoaDon hoaDon) {
        hoaDonRepository.add(hoaDon);
    }

    public void update(HoaDon hoaDon) {
        hoaDonRepository.update(hoaDon);
    }

    public void delete(Integer id) {
        hoaDonRepository.delete(id);
    }public List<HoaDon> getPage(int page, int pageSize, String keyword, Integer trangThai) {
        return hoaDonRepository.getPage(page, pageSize, keyword, trangThai);
    }
    public long count(String keyword, Integer trangThai) {
        return hoaDonRepository.count(keyword, trangThai);
    }
}