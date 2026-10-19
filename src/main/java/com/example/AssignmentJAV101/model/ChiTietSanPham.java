
package com.example.AssignmentJAV101.model;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name = "ChiTietSanPham")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChiTietSanPham {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Integer id;

    // Các trường này lưu ID khóa ngoại trong database.
    // Ở bước quản lý biến thể, ta sẽ JOIN để lấy tên sản phẩm,
    // màu sắc và kích cỡ tương ứng.
//    @Column(name = "IdSanPham", nullable = false)
//    private Integer idSanPham;
//
//    @Column(name = "IdMauSac", nullable = false)
//    private Integer idMauSac;
//
//    @Column(name = "IdKichCo", nullable = false)
//    private Integer idKichCo;

    @ManyToOne
    @JoinColumn(name = "IdSanPham")
    private SanPham sanPham;

    @ManyToOne
    @JoinColumn(name = "IdMauSac")
    private MauSac mauSac;

    @ManyToOne
    @JoinColumn(name = "IdKichCo")
    private KichCo kichCo;

    @Column(name = "GiaBan", nullable = false, precision = 18, scale = 2)
    private BigDecimal giaBan;

    @Column(name = "SoLuongTon", nullable = false)
    private Integer soLuongTon;

    @Column(name = "TrangThai")
    private Integer trangThai;
}
