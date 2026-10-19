package com.example.AssignmentJAV101.service;

import com.example.AssignmentJAV101.model.KichCo;
import com.example.AssignmentJAV101.repository.KichCoRepository;

import java.util.List;

public class KichCoService {
    private final KichCoRepository kichCoRepository = new KichCoRepository();

    public List<KichCo> getAll() {
        return kichCoRepository.getAll();
    }

    public KichCo getOne(Integer id) {
        return kichCoRepository.getOne(id);
    }

    public void add(KichCo kichCo) {
        kichCoRepository.add(kichCo);
    }

    public void update(KichCo kichCo) {
        kichCoRepository.update(kichCo);
    }

    public void delete(Integer id) {
        kichCoRepository.delete(id);
    }

}