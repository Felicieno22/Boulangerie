package com.example.boulangerie.repositories;

import com.example.boulangerie.entities.TypeProduit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TypeProduitRepository extends JpaRepository<TypeProduit, Integer> {
    @Query("SELECT tp FROM TypeProduit tp ORDER BY tp.nomTypeProduit")
    List<TypeProduit> findAllOrderByNomType();
}