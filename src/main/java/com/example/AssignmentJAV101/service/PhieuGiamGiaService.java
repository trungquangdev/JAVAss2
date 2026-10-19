package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.PhieuGiamGia;
import com.example.AssignmentJAV101.repository.PhieuGiamGiaRepository;

import java.util.List;

public class PhieuGiamGiaService {
    private final PhieuGiamGiaRepository phieuGiamGiaRepository = new PhieuGiamGiaRepository();

    public List<PhieuGiamGia> getAll() {
        return phieuGiamGiaRepository.getAll();
    }

    public PhieuGiamGia getOne(Integer id) {
        return phieuGiamGiaRepository.getOne(id);
    }

    public void add(PhieuGiamGia phieuGiamGia) {
        phieuGiamGiaRepository.add(phieuGiamGia);
    }

    public void update(PhieuGiamGia phieuGiamGia) {
        phieuGiamGiaRepository.update(phieuGiamGia);
    }

    public void delete(Integer id) {
        phieuGiamGiaRepository.delete(id);
    }

}