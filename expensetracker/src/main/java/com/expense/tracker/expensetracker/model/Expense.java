package com.expense.tracker.expensetracker.model;

import java.math.BigDecimal;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "tbl_expenses")
@Setter
@Getter
@ToString
public class Expense {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "description")
    private String expensename;

    private BigDecimal amount;

    private String note;

    @Column(name = "created_at")
    private Long createdAt;

}