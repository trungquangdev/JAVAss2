package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.HoaDonChiTiet;
import com.example.AssignmentJAV101.repository.HoaDonChiTietRepository;

import java.util.List;

public class HoaDonChiTietService {
    private final HoaDonChiTietRepository hoaDonChiTietRepository = new HoaDonChiTietRepository();

    public List<HoaDonChiTiet> getAll() {
        return hoaDonChiTietRepository.getAll();
    }

    public HoaDonChiTiet getOne(Integer id) {
        return hoaDonChiTietRepository.getOne(id);
    }

    public void add(HoaDonChiTiet hoaDonChiTiet) {
        hoaDonChiTietRepository.add(hoaDonChiTiet);
    }

    public void update(HoaDonChiTiet hoaDonChiTiet) {
        hoaDonChiTietRepository.update(hoaDonChiTiet);
    }

    public void delete(Integer id) {
        hoaDonChiTietRepository.delete(id);
    }public List<HoaDonChiTiet> getPage(int page, int pageSize, Integer idHoaDon) {
        return hoaDonChiTietRepository.getPage(page, pageSize, idHoaDon);
    }
    public long count(Integer idHoaDon) {
        return hoaDonChiTietRepository.count(idHoaDon);
    }
}