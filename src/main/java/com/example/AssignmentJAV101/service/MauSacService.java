package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.MauSac;
import com.example.AssignmentJAV101.repository.MauSacRepository;

import java.util.List;

public class MauSacService {
    private final MauSacRepository mauSacRepository = new MauSacRepository();

    public List<MauSac> getAll() {
        return mauSacRepository.getAll();
    }

    public MauSac getOne(Integer id) {
        return mauSacRepository.getOne(id);
    }

    public void add(MauSac mauSac) {
        mauSacRepository.add(mauSac);
    }

    public void update(MauSac mauSac) {
        mauSacRepository.update(mauSac);
    }

    public void delete(Integer id) {
        mauSacRepository.delete(id);
    }

}