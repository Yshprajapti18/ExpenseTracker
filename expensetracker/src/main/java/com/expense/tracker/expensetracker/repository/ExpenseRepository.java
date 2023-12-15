package com.expense.tracker.expensetracker.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.expense.tracker.expensetracker.model.Expense;

@Repository
public interface ExpenseRepository extends JpaRepository<Expense, Long> {

}