package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.DotGiamGia;
import com.example.AssignmentJAV101.repository.DotGiamGiaRepository;

import java.util.List;

public class DotGiamGiaService {
    private final DotGiamGiaRepository dotGiamGiaRepository = new DotGiamGiaRepository();

    public List<DotGiamGia> getAll() {
        return dotGiamGiaRepository.getAll();
    }

    public DotGiamGia getOne(Integer id) {
        return dotGiamGiaRepository.getOne(id);
    }

    public void add(DotGiamGia dotGiamGia) {
        dotGiamGiaRepository.add(dotGiamGia);
    }

    public void update(DotGiamGia dotGiamGia) {
        dotGiamGiaRepository.update(dotGiamGia);
    }

    public void delete(Integer id) {
        dotGiamGiaRepository.delete(id);
    }

}